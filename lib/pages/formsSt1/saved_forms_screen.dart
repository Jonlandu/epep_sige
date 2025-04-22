import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              final date = DateTime.parse(form['created_at']);
              final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(date);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(form['nom_etablissement'] ?? 'Formulaire #${form['id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Créé le: $dateStr'),
                      Text('Statut: ${form['is_synced'] == 1 ? 'Synchronisé' : 'En attente'}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        form['is_synced'] == 1 ? Icons.cloud_done : Icons.cloud_off,
                        color: form['is_synced'] == 1 ? Colors.green : Colors.orange,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteForm(form['id']),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Afficher les détails du formulaire
                  },
                ),
              );
            },
          );
        },
      ),
    );
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

    if (confirmed == true) {
      try {
        await _dbHelper.deleteForm(id);
        _refreshForms();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulaire supprimé')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }
}