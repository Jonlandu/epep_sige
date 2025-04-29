import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epsp_sige/controllers/SyncServiceController.dart';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/models/SchoolForm.dart';
import 'package:epsp_sige/utils/Routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Step6 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;
  final Function? send;
  // final int idannee;
  // final int idetablissement;
  // final String userToken;

  Step6({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
    this.send,
    // required this.idannee,
    // required this.idetablissement,
    // required this.userToken,
  });

  @override
  _Step6State createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  bool _isValidated = false;
  bool _isSubmitting = false;

  final SyncServiceController _syncService = SyncServiceController();
  final Connectivity _connectivity = Connectivity();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _isValidated = widget.formData['validation'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 8),
              _buildSubtitle(),
              const SizedBox(height: 10),
              _buildSummaryCard(),
              const SizedBox(height: 19),
              _buildValidationCheckbox(),
              if (!_isValidated) _buildValidationWarning(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildInfoText(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : () => _saveFormLocally(),
                    child: _isSubmitting
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Enregistrer en local"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveFormLocally() async {
    setState(() => _isSubmitting = true);

    try {
      // Vérifier la validation
      if (!_isValidated) {
        throw Exception(
            'Vous devez valider le formulaire avant enregistrement');
      }

      // Créer l'objet SchoolForm
      final form = SchoolForm(
        //idannee: widget.idannee,
        //idetablissement: widget.idetablissement,
        data: widget.formData,
        isSynced: false,
        //createdAt: DateTime.now().toString(), // This works as-is
      );

      // Sauvegarder en local
      final id = await _dbHelper.saveForm(form.toMap());

      if (id > 0) {
        // Succès de l'enregistrement local
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Formulaire enregistré avec succès (ID: $id)'),
            backgroundColor: Colors.green,
          ),
        );

        // Optionnel: vérifier la connexion et tenter une synchronisation
        final connectivityResult = await _connectivity.checkConnectivity();
        // if (connectivityResult != ConnectivityResult.none) {
        //   try {
        //     final response = await _syncService.syncForm(widget.formData,
        //         token: widget.userToken);
        //     if (response.status) {
        //       await _dbHelper.markFormAsSynced(id);
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         SnackBar(
        //           content: Text('Synchronisation réussie avec le serveur'),
        //           backgroundColor: Colors.green,
        //         ),
        //       );
        //     }
        //   } catch (e) {
        //     // La synchronisation a échoué mais le formulaire est bien enregistré localement
        //     await _dbHelper.scheduleSync(id);
        //   }
        // }
      } else {
        throw Exception('Erreur lors de l\'enregistrement local');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  // Les autres méthodes (_buildTitle, _buildSubtitle, etc.) restent inchangées
  Widget _buildTitle() {
    return Text(
      'Validation',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red.shade800,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black87),
              children: [
                TextSpan(
                  text:
                      'Ceci est un aperçu. Vérifiez les informations avant soumission. Après soumission, vous pourrez le modifier :  ',
                ),
                TextSpan(
                  text: 'Ici',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(
                          context, Routes.SavedFormsScreenRoutes);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ..._buildSummaryItems(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSummaryItems() {
    return [
      // Step 1 fields
      _buildSummarySection("Identification de l'Établissement", [
        _buildSummaryItem("Nom de l'établissement", "nom_etablissement"),
        _buildSummaryItem(
            "Adresse de l'établissement", "adresse_etablissement"),
        _buildSummaryItem(
            "Téléphone de l'établissement", "telephone_etablissement"),
        _buildSummaryItem("Année", "annee"),
      ]),

      _buildSummarySection("Localisation Administrative", [
        _buildSummaryItem("Province", "province"),
        _buildSummaryItem("Ville", "ville"),
        _buildSummaryItem("Territoire ou commune", "territoire_commune"),
        _buildSummaryItem("Village", "village"),
        _buildSummaryItem("Province éducationnelle", "province_educationnelle"),
        _buildSummaryItem("Code Adm Ets", "code_adm_ets"),
        _buildSummaryItem("Code Adm. Ets (auto)", "code_adm_ets_auto"),
        _buildSummaryItem("Régime de gestion", "regime_gestion"),
      ]),

      // ... (toutes les autres sections de résumé restent inchangées)
      // Vous pouvez garder tout le reste du code tel quel
    ];
  }

  Widget _buildSummaryBooleanItem(String label, String key) {
    return _buildSummaryItem(
      label,
      key,
      value: widget.formData[key] == true ? "Oui" : "Non",
    );
  }

  Widget _buildSummaryItem(String label, String key, {String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const Text(": ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            flex: 3,
            child: Text(
              value ?? widget.formData[key]?.toString() ?? 'Non spécifié',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildValidationCheckbox() {
    return Card(
      elevation: 0,
      color: Colors.red.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _isValidated ? Colors.green : Colors.red.shade300,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CheckboxListTile(
          title: const Text(
            'Je certifie que les informations fournies sont exactes',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          value: _isValidated,
          onChanged: (bool? value) {
            setState(() {
              _isValidated = value ?? false;
              widget.formData['validation'] = _isValidated;
            });
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: Colors.green,
          checkColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildValidationWarning() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Vous devez accepter cette déclaration pour soumettre',
        style: TextStyle(color: Colors.red.shade600),
      ),
    );
  }

  Widget _buildInfoText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text:
                'Pour des raisons de sécurité, une fois certifiées, ces informations seront enregistrées localement et vous pourrez les envoyer :  ',
          ),
          TextSpan(
            text: 'Ici',
            style: TextStyle(
                fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, Routes.SavedFormsScreenRoutes);
              },
          ),
        ],
      ),
    );
  }
}
