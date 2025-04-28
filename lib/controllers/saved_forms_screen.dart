import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/utils/Queries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // Import pour jsonDecode

class SavedFormsScreen extends StatefulWidget {
  const SavedFormsScreen({super.key});

  @override
  State<SavedFormsScreen> createState() => _SavedFormsScreenState();
}

class _SavedFormsScreenState extends State<SavedFormsScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> _formsFuture;

  @override
  void initState() {
    super.initState();
    _refreshForms();
  }

  void _refreshForms() {
    setState(() {
      _formsFuture = _dbHelper.getAllForms();
    });
  }

  Map<String, dynamic> _parseFormData(dynamic formData) {
    try {
      if (formData == null) return {};
      if (formData is Map) return Map<String, dynamic>.from(formData);
      if (formData is String) {
        return Map<String, dynamic>.from(jsonDecode(formData));
      }
      return {};
    } catch (e) {
      debugPrint('Error parsing form data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaires Sauvegardés'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshForms,
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _formsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun formulaire sauvegardé'));
          }

          final forms = snapshot.data!;
          return ListView.builder(
            itemCount: forms.length,
            itemBuilder: (context, index) {
              final form = forms[index];
              final date = DateTime.tryParse(form['created_at'] ?? '') ?? DateTime.now();
              final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(date);
              final isSynced = form['is_synced'] == 1;
              final formData = _parseFormData(form['form_data']);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(
                    form['nom_etablissement']?.toString() ?? 'Formulaire #${form['id']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Année: ${formData['annee_scolaire']?.toString() ?? 'N/A'}'),
                      Text('Créé le: $dateStr'),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: isSynced ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isSynced ? 'Synchronisé' : 'Non envoyé',
                            style: TextStyle(
                              color: isSynced ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!isSynced)
                        IconButton(
                          icon: const Icon(Icons.cloud_upload, color: Colors.blue),
                          onPressed: () => _sendFormToApi(form['id'], formData),
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteForm(form['id']),
                      ),
                    ],
                  ),
                  onTap: () => _showFormDetails(form['id'], formData, isSynced),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _sendFormToApi(int id, Map<String, dynamic> formData) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Appel à l'API
      final response = await postData('/st/', formData);

      if (response.status) {
        // Marquer comme synchronisé dans la base de données locale
        await _dbHelper.markFormAsSynced(id);

        if (mounted) {
          Navigator.pop(context);
          _refreshForms();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Formulaire envoyé avec succès!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur API: ${response.errorMsg ?? "Erreur inconnue"}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'envoi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
  Future<void> _showFormDetails(int id, Map<String, dynamic> formData, bool isSynced) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormDetailsScreen(
          formId: id,
          formData: formData,
          isSynced: isSynced,
        ),
      ),
    );

    if (result == true && mounted) {
      _refreshForms();
    }
  }

  Future<void> _deleteForm(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Voulez-vous vraiment supprimer ce formulaire?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await _dbHelper.deleteForm(id);
        _refreshForms();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Formulaire supprimé'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class FormDetailsScreen extends StatefulWidget {
  final int formId;
  final Map<String, dynamic> formData;
  final bool isSynced;

  const FormDetailsScreen({
    super.key,
    required this.formId,
    required this.formData,
    required this.isSynced,
  });

  @override
  State<FormDetailsScreen> createState() => _FormDetailsScreenState();
}

class _FormDetailsScreenState extends State<FormDetailsScreen> {
  late Map<String, dynamic> _editedData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _editedData = Map<String, dynamic>.from(widget.formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du formulaire #${widget.formId}'),
        actions: [
          if (!widget.isSynced)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveChanges,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Statut: ${widget.isSynced ? 'Synchronisé' : 'Non synchronisé'}',
                style: TextStyle(
                  color: widget.isSynced ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Données du formulaire:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._editedData.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (!widget.isSynced)
                        TextFormField(
                          initialValue: entry.value?.toString() ?? '',
                          onChanged: (value) {
                            _editedData[entry.key] = value;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                      else
                        Text(
                          entry.value?.toString() ?? 'N/A',
                          style: const TextStyle(fontSize: 16),
                        ),
                      const Divider(),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
      floatingActionButton: !widget.isSynced
          ? FloatingActionButton.extended(
        onPressed: _saveChanges,
        icon: const Icon(Icons.save),
        label: const Text('Enregistrer'),
      )
          : null,
    );
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate() && mounted) {
      try {
        final dbHelper = DatabaseHelper();
        await dbHelper.updateFormData(widget.formId, _editedData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Modifications enregistrées!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}