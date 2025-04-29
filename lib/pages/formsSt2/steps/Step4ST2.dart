import 'package:flutter/material.dart';

class Step4st2 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step4st2({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step4st2State createState() => _Step4st2State();
}

class _Step4st2State extends State<Step4st2> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("Resultat a l'ENAFEP de l'annee Precedente"),

            // Enfants inscrits
            _buildSection(
              title: "Effectif des élèves",
              children: [
                _buildEffectifTable(),
                const SizedBox(height: 20),
              ],
            ),
            _buildHeader(
                "Nombre d'abscences, visite médicale et déparasitage d'élèves enregistrés durant l'année scolaire précedente et par niveau d'études"),
            // Totaux par classe
            _buildSection(
              title: "Totaux par classe",
              children: [
                _buildTotalStudentsTable(),
              ],
            ),

            // Navigation buttons
            _buildNavigationButtons(),
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

  Widget _buildEffectifTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Type d'effectif",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Garçons",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Filles",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _buildEffectifRow("Élèves inscrits", "st2_effectif_eleves_inscrit_g",
            "st2_effectif_eleves_inscrit_f"),
        _buildEffectifRow("Élèves présents", "st2_effectif_eleves_present_g",
            "st2_effectif_eleves_present_f"),
        _buildEffectifRow("Élèves admis", "st2_effectif_eleves_admis_g",
            "st2_effectif_eleves_admis_f"),
        _buildEffectifRow("Élèves admis (français)",
            "st2_effectif_eleves_admis_francais_g", "st2_effectif_math_f"),
      ],
    );
  }

  TableRow _buildEffectifRow(String label, String keyG, String keyF) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyG),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyF),
        ),
      ],
    );
  }

  Widget _buildTotalStudentsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
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
                "Total élèves",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _buildTotalStudentsRow("1ère année", "st2_nombre_total_eleves_1"),
        _buildTotalStudentsRow("2ème année", "st2_nombre_total_eleves_2"),
        _buildTotalStudentsRow("3ème année", "st2_nombre_total_eleves_3"),
        _buildTotalStudentsRow("4ème année", "st2_nombre_total_eleves_4"),
        _buildTotalStudentsRow("5ème année", "st2_nombre_total_eleves_5"),
        _buildTotalStudentsRow("6ème année", "st2_nombre_total_eleves_6"),
      ],
    );
  }

  TableRow _buildTotalStudentsRow(String label, String keyTotal) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyTotal),
        ),
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
