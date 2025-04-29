import 'package:flutter/material.dart';

class Step6st2 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step6st2({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step6st2State createState() => _Step6st2State();
}

class _Step6st2State extends State<Step6st2> {
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
            _buildHeader("Statistiques de l'Établissement"),

            // Section: Manuels
            _buildSection(
              title: "Manuels",
              children: [
                _buildManualsTable(),
                const SizedBox(height: 20),
              ],
            ),

            // Section: Matériel
            _buildSection(
              title: "Matériel",
              children: [
                _buildMaterialsTable(),
                const SizedBox(height: 20),
              ],
            ),

            // Section: Salles de cours
            _buildSection(
              title: "Salles de cours",
              children: [
                _buildClassroomsTable(),
                const SizedBox(height: 20),
              ],
            ),

            // Section: Latrines
            _buildSection(
              title: "Latrines",
              children: [
                _buildLatrinesTable(),
                const SizedBox(height: 20),
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

  Widget _buildManualsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Type de manuel",
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
            "Français (Préprimaire)", "st2_manuel_francais_preprimaire"),
        _buildManualRow("Français (4ème)", "st2_manuel_francais_4"),
        _buildManualRow("Français (5ème)", "st2_manuel_francais_5"),
        _buildManualRow("Français (6ème)", "st2_manuel_francais_6"),
        _buildManualRow(
            "Mathématiques (Préprimaire)", "st2_manuel_math_preprimaire"),
        // Add more manual rows as needed
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

  Widget _buildMaterialsTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Type de matériel",
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
        _buildMaterialRow("Tableaux (Bon état)", "st2_tableaux_bon"),
        _buildMaterialRow("Tableaux (Mauvais état)", "st2_tableaux_mauvais"),
        _buildMaterialRow("Tables (Bon état)", "st2_tables_bon"),
        _buildMaterialRow("Tables (Mauvais état)", "st2_tables_mauvais"),
        // Add more material rows as needed
      ],
    );
  }

  TableRow _buildMaterialRow(String label, String key) {
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

  Widget _buildClassroomsTable() {
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
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Type de salle",
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
        _buildClassroomRow(
            "Salles de cours (Dur)",
            "st2_salle_cours_endur_bon_etat",
            "st2_salle_cours_endur_mauvais_etat"),
        _buildClassroomRow(
            "Salles de cours (Semi-dur)",
            "st2_salle_cours_semi_dur_bon_etat",
            "st2_salle_cours_semi_dur_mauvais_etat"),
        // Add more classroom rows as needed
      ],
    );
  }

  TableRow _buildClassroomRow(String label, String keyGood, String keyBad) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyGood),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyBad),
        ),
      ],
    );
  }

  Widget _buildLatrinesTable() {
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
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Type de latrines",
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
        _buildLatrineRow("Latrines (Dur)", "st2_latrines_endur_bon_etat",
            "st2_latrines_endur_mauvais_etat"),
        _buildLatrineRow(
            "Latrines (Semi-dur)",
            "st2_latrines_semi_dur_bon_etat",
            "st2_latrines_semi_dur_mauvais_etat"),
        // Add more latrine rows as needed
      ],
    );
  }

  TableRow _buildLatrineRow(String label, String keyGood, String keyBad) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyGood),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyBad),
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
