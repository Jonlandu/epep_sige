import 'package:flutter/material.dart';

class Step3ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step3ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step3ST3State createState() => _Step3ST3State();
}

class _Step3ST3State extends State<Step3ST3> {
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
            _buildHeader("Répartition du Personnel Enseignant"),

            // Section: Enseignants par qualification
            _buildSection(
              title:
                  "3.1-3.36. Répartition du personnel enseignant par sexe et qualification",
              children: [
                _buildQualificationTable(
                  title: "Enseignants -D4",
                  prefix: "enseignants_d4",
                ),
                const SizedBox(height: 20),
                _buildQualificationTable(
                  title: "Enseignants EM",
                  prefix: "enseignants_em",
                ),
                const SizedBox(height: 20),
                _buildQualificationTable(
                  title: "Enseignants D4",
                  prefix: "enseignants_d4p",
                ),
                const SizedBox(height: 20),
                _buildQualificationTable(
                  title: "Enseignants P6",
                  prefix: "enseignants_p6",
                ),
                const SizedBox(height: 20),
                _buildQualificationTable(
                  title: "Enseignants D6",
                  prefix: "enseignants_d6",
                ),
                const SizedBox(height: 20),
                _buildQualificationTable(
                  title: "Enseignants autres qualifications",
                  prefix: "enseignants_autres",
                ),
              ],
            ),

            // Navigation buttons
            _buildNavigationButtons(),
            const SizedBox(
              height: 10,
            ),
            _buildRetirementEligibilityField(),
          ],
        ),
      ),
    );
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

  Widget _buildQualificationTable(
      {required String title, required String prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
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
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.5),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Année",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Hommes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Femmes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            _buildQualificationRow(
                "1ère année", "${prefix}_hommes_1ere", "${prefix}_femmes_1ere"),
            _buildQualificationRow(
                "2ème année", "${prefix}_hommes_2eme", "${prefix}_femmes_2eme"),
            _buildQualificationRow(
                "3ème année", "${prefix}_hommes_3eme", "${prefix}_femmes_3eme"),
          ],
        ),
      ],
    );
  }

  TableRow _buildQualificationRow(
      String yearLabel, String keyHommes, String keyFemmes) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(yearLabel),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyHommes),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyFemmes),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              final hommes =
                  int.tryParse(widget.formData[keyHommes]?.toString() ?? '0') ??
                      0;
              final femmes =
                  int.tryParse(widget.formData[keyFemmes]?.toString() ?? '0') ??
                      0;
              return Text(
                (hommes + femmes).toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRetirementEligibilityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "3.37. Personnel éligible à la retraite (65 ans et plus et 35 ans de services)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
        _buildNumberFormField(label: "", key: "personnel_eligible_retraite"),
      ],
    );
  }

  Widget _buildNumberFormField({
    required String label,
    required String key,
  }) {
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
        setState(() {}); // Pour recalculer les totaux
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
