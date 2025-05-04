import 'package:flutter/material.dart';

class Step2 extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;
  final PageController controller;

  const Step2({
    super.key,
    required this.formData,
    required this.formKey,
    required this.controller,
  });

  @override
  _SchoolEnrollmentFormState createState() => _SchoolEnrollmentFormState();
}

class _SchoolEnrollmentFormState extends State<Step2> {
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
            _buildHeader("Effectifs des enfants inscrits"),

            // Section 1: Effectifs par âge et année
            _buildSection(
              title: "2.1-2.18. Effectifs par âge et année",
              children: [
                _buildAgeYearTable(),
                const SizedBox(height: 20),
              ],
            ),

            // Section 2: Groupes spécifiques
            _buildSection(
              title: "2.19-2.60. Groupes spécifiques",
              children: [
                _buildSpecialGroupsTable(),
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

  Widget _buildAgeYearTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10,
        horizontalMargin: 10,
        columns: const [
          DataColumn(
              label:
                  Text('Année', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label:
                  Text('Âge', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Garçons',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(
              label: Text('Filles',
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: [
          ..._buildAgeRowsForYear("1ère année", "1ere"),
          ..._buildAgeRowsForYear("2ème année", "2eme"),
          ..._buildAgeRowsForYear("3ème année", "3eme"),
        ],
      ),
    );
  }

  List<DataRow> _buildAgeRowsForYear(String yearLabel, String yearKey) {
    return [
      _buildAgeRow(yearLabel, "3 ans", "3ans", yearKey),
      _buildAgeRow(yearLabel, "4 ans", "4ans", yearKey),
      _buildAgeRow(yearLabel, "5 ans", "5ans", yearKey),
    ];
  }

  DataRow _buildAgeRow(
      String year, String ageLabel, String ageKey, String yearKey) {
    return DataRow(
      cells: [
        DataCell(Text(year)),
        DataCell(Text(ageLabel)),
        DataCell(
          SizedBox(
            width: 80,
            child: _buildNumberFormField(
              label: "",
              key: "effectif_garcons_${ageKey}_$yearKey",
            ),
          ),
        ),
        DataCell(
          SizedBox(
            width: 80,
            child: _buildNumberFormField(
              label: "",
              key: "effectif_filles_${ageKey}_$yearKey",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialGroupsTable() {
    return Column(
      children: [
        _buildGroupTable("Autochtones", "autochtones"),
        const SizedBox(height: 20),
        _buildGroupTable("Étrangers", "etrangers"),
        const SizedBox(height: 20),
        _buildGroupTable("Orphelins", "orphelins"),
        const SizedBox(height: 20),
        _buildGroupTable("Réfugiés", "refugies"),
        const SizedBox(height: 20),
        _buildGroupTable("Déplacés externes", "deplaces_externes"),
        const SizedBox(height: 20),
        _buildGroupTable("Déplacés internes", "deplaces_internes"),
        const SizedBox(height: 20),
        _buildGroupTable("Réintégrants", "reintegrants"),
        const SizedBox(height: 20),
        _buildGroupTable("Avec handicaps", "handicaps"),
      ],
    );
  }

  Widget _buildGroupTable(String groupName, String groupKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          groupName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.blueGrey.shade50),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Année",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Garçons",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Filles",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            _buildGroupRow("1ère année", "${groupKey}_garcons_1ere",
                "${groupKey}_filles_1ere"),
            _buildGroupRow("2ème année", "${groupKey}_garcons_2eme",
                "${groupKey}_filles_2eme"),
            _buildGroupRow("3ème année", "${groupKey}_garcons_3eme",
                "${groupKey}_filles_3eme"),
          ],
        ),
      ],
    );
  }

  TableRow _buildGroupRow(String year, String keyG, String keyF) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(year),
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
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          onPressed: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
          child: const Text('Précédent'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
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
