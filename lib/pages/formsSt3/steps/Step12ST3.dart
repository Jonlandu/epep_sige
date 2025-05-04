import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epsp_sige/controllers/SyncServiceController.dart';
import 'package:epsp_sige/models/DatabaseHelper.dart';
import 'package:epsp_sige/models/SchoolForm.dart';
import 'package:flutter/material.dart';

class Step12ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step12ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _SchoolResourcesFormState createState() => _SchoolResourcesFormState();
}

class _SchoolResourcesFormState extends State<Step12ST3> {
  //
  bool _isValidated = false;
  bool _isSubmitting = false;

  final SyncServiceController _syncService = SyncServiceController();
  final Connectivity _connectivity = Connectivity();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  //
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader("Ressources et Infrastructures de l'Établissement"),

            // Section 1: Manuels scolaires
            _buildSection(
              title: "Manuels scolaires disponibles",
              children: [
                _buildManualTable("Français", "francais"),
                const SizedBox(height: 20),
                _buildManualTable("Mathématiques", "math"),
                const SizedBox(height: 20),
                _buildManualTable("Eveil", "eveil"),
                const SizedBox(height: 20),
                _buildManualTable("ECM", "ecm"),
                const SizedBox(height: 20),
                _buildManualTable("Thèmes Transversaux", "themes_transversaux"),
                const SizedBox(height: 20),
                _buildManualTable("Education pour la Paix", "education_paix"),
                const SizedBox(height: 20),
                _buildManualTable("Autres", "autres"),
              ],
            ),

            // Section 2: Guides pédagogiques
            _buildSection(
              title: "Guides pédagogiques disponibles",
              children: [
                _buildGuideTable("Français", "francais"),
                const SizedBox(height: 20),
                _buildGuideTable("Mathématiques", "math"),
                const SizedBox(height: 20),
                _buildGuideTable("Eveil", "eveil"),
                const SizedBox(height: 20),
                _buildGuideTable("ECM", "ecm"),
                const SizedBox(height: 20),
                _buildGuideTable("Thèmes Transversaux", "themes_transversaux"),
                const SizedBox(height: 20),
                _buildGuideTable("Education pour la Paix", "education_paix"),
                const SizedBox(height: 20),
                _buildGuideTable("Autres", "autres"),
              ],
            ),

            // Section 3: Infrastructures
            _buildSection(
              title: "État des infrastructures",
              children: [
                _buildInfrastructureTable("Salles de cours", "salle_cours"),
                const SizedBox(height: 20),
                _buildInfrastructureTable(
                    "Salles spécialisées", "salle_specialisee"),
                const SizedBox(height: 20),
                _buildInfrastructureTable("Latrines", "latrines"),
              ],
            ),

            // Section 4: Matériel
            _buildSection(
              title: "État du matériel",
              children: [
                _buildMaterialTable(),
              ],
            ),
            const SizedBox(height: 19),
            _buildValidationCheckbox(),

            // Navigation buttons
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

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const Divider(thickness: 1),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildManualTable(String subject, String subjectKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            subject,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Niveau",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Quantité",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildManualRow(
                "Préprimaire", "st2_manuel_${subjectKey}_preprimaire"),
            if (subjectKey == "math" ||
                subjectKey == "ecm" ||
                subjectKey == "education_paix")
              _buildManualRow("1ère année", "st2_manuel_${subjectKey}_1"),
            if (subjectKey == "math" ||
                subjectKey == "ecm" ||
                subjectKey == "education_paix")
              _buildManualRow("2ème année", "st2_manuel_${subjectKey}_2"),
            if (subjectKey == "math" ||
                subjectKey == "ecm" ||
                subjectKey == "education_paix")
              _buildManualRow("3ème année", "st2_manuel_${subjectKey}_3"),
            if (subjectKey != "math" &&
                subjectKey != "ecm" &&
                subjectKey != "education_paix")
              _buildManualRow("4ème année", "st2_manuel_${subjectKey}_4"),
            if (subjectKey != "math" &&
                subjectKey != "ecm" &&
                subjectKey != "education_paix")
              _buildManualRow("5ème année", "st2_manuel_${subjectKey}_5"),
            if (subjectKey != "math" &&
                subjectKey != "ecm" &&
                subjectKey != "education_paix")
              _buildManualRow("6ème année", "st2_manuel_${subjectKey}_6"),
          ],
        ),
      ],
    );
  }

  Widget _buildGuideTable(String subject, String subjectKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            subject,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Niveau",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Quantité",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildManualRow(
                "Préprimaire", "st2_guide_${subjectKey}_preprimaire"),
            if (subjectKey == "math" ||
                subjectKey == "ecm" ||
                subjectKey == "education_paix")
              _buildManualRow("1ère année", "st2_guide_${subjectKey}_1"),
            if (subjectKey == "math" ||
                subjectKey == "ecm" ||
                subjectKey == "education_paix")
              _buildManualRow("2ème année", "st2_guide_${subjectKey}_2"),
            if (subjectKey == "math" ||
                subjectKey == "ecm" ||
                subjectKey == "education_paix")
              _buildManualRow("3ème année", "st2_guide_${subjectKey}_3"),
            if (subjectKey != "math" &&
                subjectKey != "ecm" &&
                subjectKey != "education_paix")
              _buildManualRow("4ème année", "st2_guide_${subjectKey}_4"),
            if (subjectKey != "math" &&
                subjectKey != "ecm" &&
                subjectKey != "education_paix")
              _buildManualRow("5ème année", "st2_guide_${subjectKey}_5"),
            if (subjectKey != "math" &&
                subjectKey != "ecm" &&
                subjectKey != "education_paix")
              _buildManualRow("6ème année", "st2_guide_${subjectKey}_6"),
          ],
        ),
      ],
    );
  }

  TableRow _buildManualRow(String label, String key) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: key),
        ),
      ],
    );
  }

  Widget _buildInfrastructureTable(String title, String prefix) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Bon état",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Mauvais état",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _buildInfrastructureRow("Durrable", "${prefix}_endur"),
        _buildInfrastructureRow("Semi-durrable", "${prefix}_semi_dur"),
        _buildInfrastructureRow("Terre battue", "${prefix}_terre_battue"),
        _buildInfrastructureRow("Paille", "${prefix}_paille"),
      ],
    );
  }

  TableRow _buildInfrastructureRow(String label, String prefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}_bon_etat"),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child:
              _buildNumberFormField(label: "", key: "${prefix}_mauvais_etat"),
        ),
      ],
    );
  }

  Widget _buildMaterialTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Matériel",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Bon état",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Mauvais état",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _buildMaterialRow("Tableaux", "st2_tableaux"),
        _buildMaterialRow("Tables", "st2_tables"),
        _buildMaterialRow("Chaises", "st2_chaises"),
        _buildMaterialRow(
            "Ordinateurs pédagogiques", "st2_ordinateur_pedagogiques"),
        _buildMaterialRow("Photocopieuses", "st2_photocopieuses"),
        _buildMaterialRow("Kits scientifiques", "st2_kits_scientifiques"),
        _buildMaterialRow("Équipements besoins spécifiques",
            "st2_equipements_besoins_specifiques"),
      ],
    );
  }

  TableRow _buildMaterialRow(String label, String prefix) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}_bon"),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: "${prefix}_mauvais"),
        ),
      ],
    );
  }

  Widget _buildNumberFormField({required String label, required String key}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      keyboardType: TextInputType.number,
      initialValue: widget.formData[key]?.toString() ?? '0',
      onChanged: (value) {
        widget.formData[key] = int.tryParse(value) ?? 0;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une valeur';
        }
        if (int.tryParse(value) == null) {
          return 'Veuillez entrer un nombre valide';
        }
        return null;
      },
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

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Précédent'),
        ),
        ElevatedButton(
          onPressed: () => widget.controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Suivant'),
        ),
      ],
    );
  }
}
