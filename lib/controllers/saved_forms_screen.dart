import 'package:epsp_sige/controllers/formulaire_enseignant.dart';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/models/SchoolModel.dart';
import 'package:epsp_sige/utils/Queries.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'dart:convert'; // Import pour jsonDecode

class SavedFormsScreen extends StatefulWidget {
  SchoolModel? school;
  String? prefix;
  String? schema_name;
  SavedFormsScreen({super.key, this.school, this.prefix, this.schema_name});

  @override
  State<SavedFormsScreen> createState() => _SavedFormsScreenState();
}

class _SavedFormsScreenState extends State<SavedFormsScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> _formsFuture;
  var box = GetStorage();

  final List<GlobalKey<FormState>> _stepFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

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
              print('form: ${jsonEncode(form)}');
              final date =
                  DateTime.tryParse(form['created_at'] ?? '') ?? DateTime.now();
              final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(date);
              final isSynced = form['is_synced'] == 1;
              final formData = _parseFormData(form['form_data']);
              //
              print("st1: ${form['st1']}");
              Map user = box.read("user");

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(
                    form['nom_etablissement']?.toString() ??
                        'Formulaire #${form['ids']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Année: ${formData['annee_scolaire']?.toString() ?? 'N/A'}'),
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
                          icon: const Icon(Icons.cloud_upload,
                              color: Colors.blue),
                          onPressed: () {
                            //
                            DateTime dt = DateTime.now();
                            //
                            if (formData["is_synced"] == null) {
                              Map e = {};
                              e["formulaire"] = formData;
                              e["date"] = "${dt.day}-${dt.month}-${dt.year}";
                              e["type"] = "st1";

                              String dd = jsonEncode(e);
                              //print('dd: $dd');
                              _sendFormToApi(form['ids'], dd);
                            } else {
                              Get.snackbar("Oups",
                                  "Ce formulaire a déjà été envoyé au serveur");
                            }
                          },
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          //
                          List finalliste = [];
                          //
                          List list1 = box.read("formData1") ?? [];
                          //
                          for (var s in list1.toList()) {
                            if (s['id'] == form['id']) {
                              list1.remove(s);
                            }
                          }
                          //
                          box.write("formData1", list1);
                          //
                          List list2 = box.read("formData2") ?? [];
                          //
                          for (var s in list2.toList()) {
                            if (s['id'] == form['id']) {
                              list2.remove(s);
                            }
                          }
                          //
                          box.write("formData2", list2);
                          //
                          List list3 = box.read("formData3") ?? [];
                          //
                          for (var s in list3.toList()) {
                            if (s['id'] == form['id']) {
                              list3.remove(s);
                            }
                          }
                          //
                          box.write("formData3", list3);
                          //
                          forms.removeAt(index);
                          //
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    if (formData["is_synced"] == null) {
                      _showFormDetails(form['ids'], formData, isSynced);
                    } else {
                      Get.snackbar(
                          "Oups", "Ce formulaire a déjà été envoyé au serveur");
                    }
                  },
                  onLongPress: () {
                    //
                    print("formData['is_synced']: ${formData["is_synced"]}");
                    //
                    if (formData["is_synced"] == null) {
                      PageController pageController = PageController();
                      //
                      if (form["st1"] == "oui") {
                        formData["label_st"] == "ST1";
                        formData['idetablissement'] = widget.school!.id;
                        formData['iduser'] = user["userInfo"]["user"]["id"];
                        formData['nom'] = widget.school!.nom;
                        formData['prefix'] = "st_2025"; // widget.schema_name;

                        //
                        formData.addAll(convertFormData(formData));

                        //
                        formData['annee'] = widget.prefix;

                        Get.to(ListEnseignantForm(formData));
                      } else {
                        //
                        print("st1: ${formData}");
                      }
                    } else {
                      Get.snackbar(
                          "Oups", "Ce formulaire a déjà été envoyé au serveur");
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _sendFormToApi(String ids, String formData) async {
    Map user = box.read("user") ?? {};
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Appel à l'API
      final response =
          await postData('/form', formData, token: user['userInfo']['access']);

      if (response.status) {
        // Marquer comme synchronisé dans la base de données locale
        await _dbHelper.markFormAsSynced(ids);

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
              content:
                  Text('Erreur API: ${response.errorMsg ?? "Erreur inconnue"}'),
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

  Future<void> _showFormDetails(
      String id, Map<String, dynamic> formData, bool isSynced) async {
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

  Map<String, dynamic> convertFormData(Map<String, dynamic> formData) {
    // Liste des clés à convertir
    List<String> keys = [
      "copa_disponible",
      "copa_operationnel",
      "coges_disponible",
      "coges_operationnel",
      "locaux_partages",
      "programme_refugies",
      "nom_organisme",
      "projet_develope",
      "prevision_budgetaire",
      "plan_action_operationel",
      "tableau_bord",
      "rap_organisee",
      "chef_cote_positivement",
      "vih_sida_enseigne",
      "vih_sida_programme",
      "vih_sida_discipline",
      "vih_sida_active_parascolaire",
      "sante_reproductive_enseigne",
      "sante_reproductive_programme",
      "sante_reproductive_discipline",
      "sante_reproductive_parascolaire",
      "sensibilisation_abus_enseigne",
      "sensibilisation_abus_programme",
      "sensibilisation_abus_discipline",
      "sensibilisation_abus_parascolaire",
      "education_environnementale_enseigne",
      "education_environnementale_programme",
      "education_environnementale_discipline",
      "education_environnementale_parascolaire",
      "reglement_securite_physique",
      "reglement_discrimination",
      "reglement_harcelement",
      "cellule_orientation_evf",
      "enseignants_evf_formes",
    ];

    Map<String, bool> converted = {};

    for (var key in keys) {
      var value = formData[key];
      converted[key] = value?.toString().trim().toLowerCase() == 'oui';
    }

    return converted;
  }
}

class FormDetailsScreen extends StatefulWidget {
  final String formId;
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
