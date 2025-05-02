import 'package:flutter/material.dart';

class Step55 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step55({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _Step55State createState() => _Step55State();
}

class _Step55State extends State<Step55> {
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

            // Section 1: Salles d'activité
            _buildSection(
              title: "Salles d'activité par année",
              children: [
                _buildClassroomTable(),
                const SizedBox(height: 10),
                const Text(
                  "Nombre de salles autorisées et organisées par niveau",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
                const SizedBox(height: 20),
              ],
            ),

            // Section 2: Enseignants
            _buildSection(
              title: "Enseignants formés et dispensant EVF",
              children: [
                _buildTeachersTable(),
                const SizedBox(height: 10),
                const Text(
                  "Répartition par genre des enseignants formés et dispensant l'éducation à la vie familiale (EVF)",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
            const Divider(thickness: 1, height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildClassroomTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          children: [
            _buildTableHeaderCell("Niveau"),
            _buildTableHeaderCell("Salles autorisées"),
            _buildTableHeaderCell("Salles organisées"),
          ],
        ),
        _buildClassroomRow("1ère année", "nb_salles_autorisees_1ere",
            "nb_salles_organisees_1ere"),
        _buildClassroomRow("2ème année", "nb_salles_autorisees_2eme",
            "nb_salles_organisees_2eme"),
        _buildClassroomRow("3ème année", "nb_salles_autorisees_3eme",
            "nb_salles_organisees_3eme"),
      ],
    );
  }

  Widget _buildTeachersTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      border: TableBorder.all(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(5),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          children: [
            _buildTableHeaderCell("Catégorie"),
            _buildTableHeaderCell("Hommes"),
            _buildTableHeaderCell("Femmes"),
          ],
        ),
        _buildTeacherRow("Enseignants formés", "nb_enseignants_forme_h",
            "nb_enseignants_forme_f"),
        _buildTeacherRow("Enseignants dispensant EVF",
            "nb_enseignants_evf_dispense_h", "nb_enseignants_evf_dispense_f"),
      ],
    );
  }

  Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildClassroomRow(String label, String keyAuth, String keyOrg) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        _buildNumberFormFieldCell(key: keyAuth),
        _buildNumberFormFieldCell(key: keyOrg),
      ],
    );
  }

  TableRow _buildTeacherRow(String label, String keyH, String keyF) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        _buildNumberFormFieldCell(key: keyH),
        _buildNumberFormFieldCell(key: keyF),
      ],
    );
  }

  Widget _buildNumberFormFieldCell({required String key}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          filled: true,
          fillColor: Colors.white,
        ),
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        initialValue: widget.formData[key]?.toString() ?? '0',
        onChanged: (value) {
          widget.formData[key] = int.tryParse(value) ?? 0;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Requis';
          }
          if (int.tryParse(value) == null) {
            return 'Nombre invalide';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Précédent'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => widget.controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Suivant'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                widget.controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
