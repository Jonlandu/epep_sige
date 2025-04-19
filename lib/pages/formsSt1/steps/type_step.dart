import 'package:flutter/material.dart';

class TypeStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const TypeStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3.2.1 Tableau 2 : effectifs des enfants inscrits par sexe et année d’études selon l’âge révolu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildChildrenEffectivesTable(),
        ],
      ),
    );
  }

  Widget _buildChildrenEffectivesTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell('Niveau d’études / Sexe / Age', isHeader: true),
            _buildTableCell('G', isHeader: true),
            _buildTableCell('F', isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell('3 ans'),
          _buildTextFormFieldCell('age3G', '0'),
          _buildTextFormFieldCell('age3F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('4 ans'),
          _buildTextFormFieldCell('age4G', '0'),
          _buildTextFormFieldCell('age4F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('5 ans et plus'),
          _buildTextFormFieldCell('age5PlusG', '0'),
          _buildTextFormFieldCell('age5PlusF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Total'),
          _buildTextFormFieldCell('totalG', '0'),
          _buildTextFormFieldCell('totalF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont autochtones'),
          _buildTextFormFieldCell('autochtoneG', '0'),
          _buildTextFormFieldCell('autochtoneF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont orphelins'),
          _buildTextFormFieldCell('orphelinsG', '0'),
          _buildTextFormFieldCell('orphelinsF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont déplacés internes'),
          _buildTextFormFieldCell('deplacesInternesG', '0'),
          _buildTextFormFieldCell('deplacesInternesF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont déplacés externes'),
          _buildTextFormFieldCell('deplacesExternesG', '0'),
          _buildTextFormFieldCell('deplacesExternesF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont ré'),
          _buildTextFormFieldCell('deplacesExternesG', '0'),
          _buildTextFormFieldCell('deplacesExternesF', '0'),
        ]),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTextFormFieldCell(String key, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      onSaved: (value) => formData[key] = value,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
}