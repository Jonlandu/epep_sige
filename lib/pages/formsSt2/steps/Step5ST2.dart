import 'package:flutter/material.dart';

class Step5st2 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step5st2({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step5st2State createState() => _Step5st2State();
}

class _Step5st2State extends State<Step5st2> {
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

            // Section: Affectation des classes
            _buildSection(
              title: "Affectation des classes",
              children: [
                _buildClassAssignmentTable(),
                const SizedBox(height: 20),
              ],
            ),
            //
            _buildNumberFormField(
                label:
                    "Parmi le personnel enseignant de votre établissement, combien sont éligible à la la retraite",
                key: UniqueKey().toString()),
            // Navigation buttons
            const SizedBox(
              height: 10,
            ),
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

  Widget _buildClassAssignmentTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.blueGrey.shade50),
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Classe",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Préd4 (Garçons)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "D4 (Garçons)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "P6 (Garçons)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "D6 (Garçons)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Autres (Garçons)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _buildClassRow("1ère année (H)", [
          "st2_class_affectation_1h_pred4",
          "st2_class_affectation_1h_d4",
          "st2_class_affectation_1h_p6",
          "st2_class_affectation_1h_d6",
          "st2_class_affectation_1h_autres",
        ]),
        _buildClassRow("1ère année (F)", [
          "st2_class_affectation_1f_pred4",
          "st2_class_affectation_1f_d4",
          "st2_class_affectation_1f_p6",
          "st2_class_affectation_1f_d6",
          "st2_class_affectation_1f_autres",
        ]),
        _buildClassRow("2ème année (H)", [
          "st2_class_affectation_2h_pred4",
          "st2_class_affectation_2h_d4",
          "st2_class_affectation_2h_p6",
          "st2_class_affectation_2h_d6",
          "st2_class_affectation_2h_autres",
        ]),
        _buildClassRow("2ème année (F)", [
          "st2_class_affectation_2f_pred4",
          "st2_class_affectation_2f_d4",
          "st2_class_affectation_2f_p6",
          "st2_class_affectation_2f_d6",
          "st2_class_affectation_2f_autres",
        ]),
        _buildClassRow("3ème année (H)", [
          "st2_class_affectation_3h_pred4",
          "st2_class_affectation_3h_d4",
          "st2_class_affectation_3h_p6",
          "st2_class_affectation_3h_d6",
          "st2_class_affectation_3h_autres",
        ]),
        _buildClassRow("3ème année (F)", [
          "st2_class_affectation_3f_pred4",
          "st2_class_affectation_3f_d4",
          "st2_class_affectation_3f_p6",
          "st2_class_affectation_3f_d6",
          "st2_class_affectation_3f_autres",
        ]),
        _buildClassRow("4ème année (H)", [
          "st2_class_affectation_4h_pred4",
          "st2_class_affectation_4h_d4",
          "st2_class_affectation_4h_p6",
          "st2_class_affectation_4h_d6",
          "st2_class_affectation_4h_autres",
        ]),
        _buildClassRow("4ème année (F)", [
          "st2_class_affectation_4f_pred4",
          "st2_class_affectation_4f_d4",
          "st2_class_affectation_4f_p6",
          "st2_class_affectation_4f_d6",
          "st2_class_affectation_4f_autres",
        ]),
        _buildClassRow("5ème année (H)", [
          "st2_class_affectation_5h_pred4",
          "st2_class_affectation_5h_d4",
          "st2_class_affectation_5h_p6",
          "st2_class_affectation_5h_d6",
          "st2_class_affectation_5h_autres",
        ]),
        _buildClassRow("5ème année (F)", [
          "st2_class_affectation_5f_pred4",
          "st2_class_affectation_5f_d4",
          "st2_class_affectation_5f_p6",
          "st2_class_affectation_5f_d6",
          "st2_class_affectation_5f_autres",
        ]),
        _buildClassRow("6ème année (H)", [
          "st2_class_affectation_6h_pred4",
          "st2_class_affectation_6h_d4",
          "st2_class_affectation_6h_p6",
          "st2_class_affectation_6h_d6",
          "st2_class_affectation_6h_autres",
        ]),
        _buildClassRow("6ème année (F)", [
          "st2_class_affectation_6f_pred4",
          "st2_class_affectation_6f_d4",
          "st2_class_affectation_6f_p6",
          "st2_class_affectation_6f_d6",
          "st2_class_affectation_6f_autres",
        ]),
      ],
    );
  }

  TableRow _buildClassRow(String label, List<String> keys) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        ...keys.map((key) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: _buildNumberFormField(label: "", key: key),
            )),
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
