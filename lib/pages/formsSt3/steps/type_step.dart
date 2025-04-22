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
            'Tableau 2 : effectifs des enfants inscrits par sexe et année d\'études selon l\'âge révolu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '3.2.1. Première année',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildChildrenEffectivesTable(),
          const SizedBox(height: 10),
          Text(
            '3.2.2. Deuxième année',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildAdditionalTable(),
          const SizedBox(height: 10),
          Text(
            '3.2.3. Troisième année',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildAdditional2Table(),
          const SizedBox(height: 10),
          Text(
            'Tableau 3 : Répartition du personnel enseignant par qualification, sexe et classe d\'affection',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildPersonnelTable(),
          const SizedBox(height: 10),
          Text(
            'Parmi le personnel enseignant de votre établissement, combien sont éligibles à la retraite (65 ans et plus de 35 ans)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade700,
            ),
          ),
          const SizedBox(height: 10),
          _buildTextFormField(
            label: 'Nombre d\'enseignants éligibles à la retraite',
            initialValue: formData['nombreEducateursFormation'],
            onSaved: (value) => formData['nombreEducateursFormation'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.school_outlined,
          ),
          const SizedBox(height: 12),
          Text(
            'Tableau 5 : Répartition du personnel administratif et ouvrier par qualification, sexe et fonction',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildAdministrativeTable(), // Ajout du tableau administratif
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
            _buildTableCell('Niveau d\'études / Sexe / Age', isHeader: true),
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
          _buildTableCell('Dont réintégrants'),
          _buildTextFormFieldCell('deplacesExternesG', '0'),
          _buildTextFormFieldCell('deplacesExternesF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont avec handicap'),
          _buildTextFormFieldCell('deplacesExternesG', '0'),
          _buildTextFormFieldCell('deplacesExternesF', '0'),
        ]),
      ],
    );
  }

  Widget _buildAdditionalTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Niveau d'études / Sexe / Age", isHeader: true),
            _buildTableCell("G", isHeader: true),
            _buildTableCell("F", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("- 3 ans"),
          _buildTextFormFieldCell('moins3G', '0'),
          _buildTextFormFieldCell('moins3F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("3 ans"),
          _buildTextFormFieldCell('age3G', '0'),
          _buildTextFormFieldCell('age3F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("4 ans"),
          _buildTextFormFieldCell('age4G', '0'),
          _buildTextFormFieldCell('age4F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("5 ans"),
          _buildTextFormFieldCell('age5G', '0'),
          _buildTextFormFieldCell('age5F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("+ 5 ans"),
          _buildTextFormFieldCell('plus5G', '0'),
          _buildTextFormFieldCell('plus5F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Total"),
          _buildTextFormFieldCell('total2G', '0'),
          _buildTextFormFieldCell('total2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont autochtone"),
          _buildTextFormFieldCell('autochtone2G', '0'),
          _buildTextFormFieldCell('autochtone2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont orphelins"),
          _buildTextFormFieldCell('orphelins2G', '0'),
          _buildTextFormFieldCell('orphelins2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont réfugiés"),
          _buildTextFormFieldCell('refugies2G', '0'),
          _buildTextFormFieldCell('refugies2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont déplacés internes"),
          _buildTextFormFieldCell('deplacer_internes2G', '0'),
          _buildTextFormFieldCell('deplacer_internes2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont déplacés externes"),
          _buildTextFormFieldCell('deplacer_externes2G', '0'),
          _buildTextFormFieldCell('deplacer_externes2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont réintégrants"),
          _buildTextFormFieldCell('dont_reintegrants2G', '0'),
          _buildTextFormFieldCell('dont_reintegrants2F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont avec handicap"),
          _buildTextFormFieldCell('dont_handicape2G', '0'),
          _buildTextFormFieldCell('dont_handicape2F', '0'),
        ]),
      ],
    );
  }

  Widget _buildAdditional2Table() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Niveau d'études / Sexe / Age", isHeader: true),
            _buildTableCell("G", isHeader: true),
            _buildTableCell("F", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("- 3 ans"),
          _buildTextFormFieldCell('moins_23G', '0'),
          _buildTextFormFieldCell('moins_23F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("3 ans"),
          _buildTextFormFieldCell('age_23G', '0'),
          _buildTextFormFieldCell('age_23F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("4 ans"),
          _buildTextFormFieldCell('age_24G', '0'),
          _buildTextFormFieldCell('age_24F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("5 ans"),
          _buildTextFormFieldCell('age_25G', '0'),
          _buildTextFormFieldCell('age_25F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("+ 5 ans"),
          _buildTextFormFieldCell('plus_25G', '0'),
          _buildTextFormFieldCell('plus_25F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Total"),
          _buildTextFormFieldCell('total_22G', '0'),
          _buildTextFormFieldCell('total_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont autochtone"),
          _buildTextFormFieldCell('autochtone_22G', '0'),
          _buildTextFormFieldCell('autochtone_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont étrangers"),
          _buildTextFormFieldCell('etrangers_2', '0'),
          _buildTextFormFieldCell('etrangers_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont orphelins"),
          _buildTextFormFieldCell('orphelins_22G', '0'),
          _buildTextFormFieldCell('orphelins_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont réfugiés"),
          _buildTextFormFieldCell('refugies_22G', '0'),
          _buildTextFormFieldCell('refugies_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont déplacés internes"),
          _buildTextFormFieldCell('deplacer_internes_22G', '0'),
          _buildTextFormFieldCell('deplacer_internes_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont déplacés externes"),
          _buildTextFormFieldCell('deplacer_externes_22G', '0'),
          _buildTextFormFieldCell('deplacer_externes_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont réintégrants"),
          _buildTextFormFieldCell('dont_reintegrants_22G', '0'),
          _buildTextFormFieldCell('dont_reintegrants_22F', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Dont avec handicap"),
          _buildTextFormFieldCell('dont_handicape_22G', '0'),
          _buildTextFormFieldCell('dont_handicape_22F', '0'),
        ]),
      ],
    );
  }

  Widget _buildPersonnelTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Qualification", isHeader: true),
            _buildTableCell("1ère H", isHeader: true),
            _buildTableCell("1ère F", isHeader: true),
            _buildTableCell("2ème H", isHeader: true),
            _buildTableCell("2ème F", isHeader: true),
            _buildTableCell("3ème H", isHeader: true),
            _buildTableCell("3ème F", isHeader: true),
            _buildTableCell("Total", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("EM"),
          _buildTextFormFieldCell('emH', '0'),
          _buildTextFormFieldCell('emF', '0'),
          _buildTextFormFieldCell('em2H', '0'),
          _buildTextFormFieldCell('em2F', '0'),
          _buildTextFormFieldCell('em3H', '0'),
          _buildTextFormFieldCell('em3F', '0'),
          _buildTextFormFieldCell('emTotal', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("D4"),
          _buildTextFormFieldCell('d4H', '0'),
          _buildTextFormFieldCell('d4F', '0'),
          _buildTextFormFieldCell('d42H', '0'),
          _buildTextFormFieldCell('d42F', '0'),
          _buildTextFormFieldCell('d43H', '0'),
          _buildTextFormFieldCell('d43F', '0'),
          _buildTextFormFieldCell('d4Total', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("P6"),
          _buildTextFormFieldCell('p6H', '0'),
          _buildTextFormFieldCell('p6F', '0'),
          _buildTextFormFieldCell('p62H', '0'),
          _buildTextFormFieldCell('p62F', '0'),
          _buildTextFormFieldCell('p63H', '0'),
          _buildTextFormFieldCell('p63F', '0'),
          _buildTextFormFieldCell('p6Total', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("D6"),
          _buildTextFormFieldCell('d6H', '0'),
          _buildTextFormFieldCell('d6F', '0'),
          _buildTextFormFieldCell('d62H', '0'),
          _buildTextFormFieldCell('d62F', '0'),
          _buildTextFormFieldCell('d63H', '0'),
          _buildTextFormFieldCell('d63F', '0'),
          _buildTextFormFieldCell('d6Total', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Autres"),
          _buildTextFormFieldCell('autres6H', '0'),
          _buildTextFormFieldCell('autres6F', '0'),
          _buildTextFormFieldCell('autres62H', '0'),
          _buildTextFormFieldCell('autres62F', '0'),
          _buildTextFormFieldCell('autres63H', '0'),
          _buildTextFormFieldCell('autres63F', '0'),
          _buildTextFormFieldCell('autres6Total', '0'),
        ]),
        TableRow(children: [
          _buildTableCell("Total"),
          _buildTextFormFieldCell('total6H', '0'),
          _buildTextFormFieldCell('total6F', '0'),
          _buildTextFormFieldCell('total62H', '0'),
          _buildTextFormFieldCell('total62F', '0'),
          _buildTextFormFieldCell('total63H', '0'),
          _buildTextFormFieldCell('total63F', '0'),
          _buildTextFormFieldCell('total6Total', '0'),
        ]),
      ],
    );
  }

  Widget _buildAdministrativeTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        // Header Row
        TableRow(
          children: [
            _buildTableCell("Qualification", isHeader: true),
            _buildTableCell("Directeur H", isHeader: true),
            _buildTableCell("Directeur F", isHeader: true),
            _buildTableCell("Directeur Adjoint H", isHeader: true),
            _buildTableCell("Directeur Adjoint F", isHeader: true),
            _buildTableCell("Surveillant H", isHeader: true),
            _buildTableCell("Surveillant F", isHeader: true),
            _buildTableCell("Ouvrier H", isHeader: true),
            _buildTableCell("Ouvrière F", isHeader: true),
            _buildTableCell("Total H", isHeader: true),
            _buildTableCell("Total F", isHeader: true),
          ],
        ),
        // Data Rows
        TableRow(children: [
          _buildTableCell("EM"),
          _buildTextFormFieldCell('emDirH', '0'),
          _buildTextFormFieldCell('emDirF', '0'),
          _buildTextFormFieldCell('emAdjH', '0'),
          _buildTextFormFieldCell('emAdjF', '0'),
          _buildTextFormFieldCell('emSurvH', '0'),
          _buildTextFormFieldCell('emSurvF', '0'),
          _buildTextFormFieldCell('emouvrierH', '0'),
          _buildTextFormFieldCell('emouvriereF', '0'),
          _buildTableCell("", isFormula: true),
          _buildTableCell("", isFormula: true),
        ]),
        TableRow(children: [
          _buildTableCell("D4"),
          _buildTextFormFieldCell('d4DirH', '0'),
          _buildTextFormFieldCell('d4DirF', '0'),
          _buildTextFormFieldCell('d4AdjH', '0'),
          _buildTextFormFieldCell('d4AdjF', '0'),
          _buildTextFormFieldCell('d4SurvH', '0'),
          _buildTextFormFieldCell('d4SurvF', '0'),
          _buildTextFormFieldCell('d4ouvrierH', '0'),
          _buildTextFormFieldCell('d4ouvriereF', '0'),
          _buildTableCell("", isFormula: true),
          _buildTableCell("", isFormula: true),
        ]),
        TableRow(children: [
          _buildTableCell("P6"),
          _buildTextFormFieldCell('p6DirH', '0'),
          _buildTextFormFieldCell('p6DirF', '0'),
          _buildTextFormFieldCell('p6AdjH', '0'),
          _buildTextFormFieldCell('p6AdjF', '0'),
          _buildTextFormFieldCell('p6SurvH', '0'),
          _buildTextFormFieldCell('p6SurvF', '0'),
          _buildTextFormFieldCell('p6ouvrierH', '0'),
          _buildTextFormFieldCell('p6ouvriereF', '0'),
          _buildTableCell("", isFormula: true),
          _buildTableCell("", isFormula: true),
        ]),
        TableRow(children: [
          _buildTableCell("D6"),
          _buildTextFormFieldCell('d6DirH', '0'),
          _buildTextFormFieldCell('d6DirF', '0'),
          _buildTextFormFieldCell('d6AdjH', '0'),
          _buildTextFormFieldCell('d6AdjF', '0'),
          _buildTextFormFieldCell('d6SurvH', '0'),
          _buildTextFormFieldCell('d6SurvF', '0'),
          _buildTextFormFieldCell('d6ouvrierH', '0'),
          _buildTextFormFieldCell('d6ouvriereF', '0'),
          _buildTableCell("", isFormula: true),
          _buildTableCell("", isFormula: true),
        ]),
        TableRow(children: [
          _buildTableCell("Autres"),
          _buildTextFormFieldCell('autresDirH', '0'),
          _buildTextFormFieldCell('autresDirF', '0'),
          _buildTextFormFieldCell('autresAdjH', '0'),
          _buildTextFormFieldCell('autresAdjF', '0'),
          _buildTextFormFieldCell('autresSurvH', '0'),
          _buildTextFormFieldCell('autresSurvF', '0'),
          _buildTextFormFieldCell('autresouvrierH', '0'),
          _buildTextFormFieldCell('autresouvriereF', '0'),
          _buildTableCell("", isFormula: true),
          _buildTableCell("", isFormula: true),
        ]),
        TableRow(children: [
          _buildTableCell("Total"),
          _buildTextFormFieldCell('total1', '0'),
          _buildTextFormFieldCell('total2', '0'),
          _buildTextFormFieldCell('total3', '0'),
          _buildTextFormFieldCell('total4', '0'),
          _buildTextFormFieldCell('total5', '0'),
          _buildTextFormFieldCell('total6', '0'),
          _buildTextFormFieldCell('total7', '0'),
          _buildTextFormFieldCell('total8', '0'),
          _buildTableCell("", isFormula: true),
          _buildTableCell("", isFormula: true),
        ]),
      ],
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool isFormula = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontStyle: isFormula ? FontStyle.italic : FontStyle.normal,
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

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    IconData? icon,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
        prefixIcon: icon != null ? Icon(icon, size: 20, color: Colors.blue.shade600) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade600, width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        isDense: true,
      ),
      style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
      validator: validator,
      onSaved: onSaved,
    );
  }
}