import 'package:flutter/material.dart';

class Step2ST3 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step2ST3({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step2ST3State createState() => _Step2ST3State();
}

class _Step2ST3State extends State<Step2ST3> {
  final List<String> _gradeLabels = [
    "Classe d'accueil (0)",
    "1ère année (1)",
    "2ème année (2)",
    "3ème année (3)",
    "4ème année (4)",
    "5ème année (5)",
    "6ème année (6)",
  ];

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
            _buildHeader("Nombre de classes autorisé et de classe organisé"),

            // Section: Classes autorisées et organisées
            _buildSection(
              title: "Répartition des Classes",
              children: [
                _buildClassTable(),
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

  Widget _buildClassTable() {
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Niveau",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Classes autorisées",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Classes organisées",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        for (int i = 0; i < _gradeLabels.length; i++)
          _buildClassRow(
            _gradeLabels[i],
            "st2_nombre_classes_autorise_$i",
            "st2_nombre_classes_organise_$i",
          ),
      ],
    );
  }

  TableRow _buildClassRow(String label, String keyAuth, String keyOrg) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyAuth),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: _buildNumberFormField(label: "", key: keyOrg),
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
