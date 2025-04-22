import 'package:flutter/material.dart';

class IdentificationStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const IdentificationStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  _IdentificationStepState createState() => _IdentificationStepState();
}

class _IdentificationStepState extends State<IdentificationStep> {
  // Variables to track if each theme is active (Oui selected)
  bool isVihSidaActive = false;
  bool isSanteSexuelleActive = false;
  bool isSensibilisationActive = false;
  bool isEducationEnvironnementaleActive = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2.51. ENFANTS VICTIMES DE VIOLENCES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildViolenceTable(),
          const SizedBox(height: 20),
          Text(
            'Note : le 2ème établissement (sous logé à la question 2.13) ne remplira pas les tableaux 8-9-10, sur les locaux',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Nombre de visites d\'inspection de l\'année passée',
            initialValue: widget.formData['visitesInspection']?.toString() ?? '',
            onSaved: (value) => widget.formData['visitesInspection'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.check_circle_outline,
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            label: 'Nombre de réunions avec PV tenues l\'année passée',
            initialValue: widget.formData['reunionsPV']?.toString() ?? '',
            onSaved: (value) => widget.formData['reunionsPV'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.event,
          ),
          const SizedBox(height: 20),
          Text(
            '3.1. Thèmes transversaux',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          const SizedBox(height: 20),
          _buildThemesTable(),
          const SizedBox(height: 20),
          Text(
            '3.2 L\'établissement a-t-il établi et communiqué des règlements et directives à l\'attention du personnel et des élèves ?',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildRegulationsTable(),
          const SizedBox(height: 20),
          Text(
            '3.3 Existe-t-il à votre établissement, une cellule d\'orientation qui intègre dans sa mission, les questions concernant l\'Éducation à la Vie Familiale (EVF) ?',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildYesNoField('celluleOrientation', 'Oui', 'Non'),
          const SizedBox(height: 20),
          Text(
            '3.4 Votre établissement dispose-t-il d\'enseignants formés pour la matière nationale d\'Éducation à la Vie Familiale (EVF) ?',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildYesNoField('enseignantsFormes', 'Oui', 'Non'),
          const SizedBox(height: 20),
          Text(
            '3.6 Parmi les enseignant-e-s formé-e-s, combien dispensent des cours ?',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildTeachingTable(),
          const SizedBox(height: 20),
          Text(
            'III. DONNEES SUR LES DIFFERENTS PARAMETRES SCOLAIRES',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildSchoolParametersTable(),
          const SizedBox(height: 20),
          Text(
            '3.2.1 Tableau 2 : effectifs des enfants inscrits par sexe et année d\'études selon l\'âge révolu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),
          _buildChildrenEffectivesTable(),
        ],
      ),
    );
  }

  Widget _buildViolenceTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Forme de violence', isHeader: true),
            _buildTableCell('G', isHeader: true),
            _buildTableCell('F', isHeader: true),
            _buildTableCell('G+F', isHeader: true),
          ],
        ),
        TableRow(children: [
          _buildTableCell('Intimidation'),
          _buildTextFormFieldCell('intimidationG', '0'),
          _buildTextFormFieldCell('intimidationF', '0'),
          _buildTextFormFieldCell('intimidationGF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Châtiment corporel'),
          _buildTextFormFieldCell('chatimentG', '0'),
          _buildTextFormFieldCell('chatimentF', '0'),
          _buildTextFormFieldCell('chatimentGF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Harcèlement'),
          _buildTextFormFieldCell('harcelementG', '0'),
          _buildTextFormFieldCell('harcelementF', '0'),
          _buildTextFormFieldCell('harcelementGF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Discrimination'),
          _buildTextFormFieldCell('discriminationG', '0'),
          _buildTextFormFieldCell('discriminationF', '0'),
          _buildTextFormFieldCell('discriminationGF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Autres'),
          _buildTextFormFieldCell('autresG', '0'),
          _buildTextFormFieldCell('autresF', '0'),
          _buildTextFormFieldCell('autresGF', '0'),
        ]),
      ],
    );
  }

  Widget _buildThemesTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Thèmes', isHeader: true),
            _buildTableCell('Oui', isHeader: true),
            _buildTableCell('Non', isHeader: true),
            _buildTableCell('Si « oui » Indiquez sous quelle forme', isHeader: true),
          ],
        ),
        TableRow(children: [
          _buildTableCell('Le VIH/Sida'),
          _buildRadioButtonCell('vihSida', 'Oui'),
          _buildRadioButtonCell('vihSida', 'Non'),
          _buildTextFormFieldCell(
            'vihSidaForme',
            isVihSidaActive ? '' : null,
            isRequired: isVihSidaActive,
          ),
        ]),
        TableRow(children: [
          _buildTableCell('La santé sexuelle et reproductive'),
          _buildRadioButtonCell('santeSexuelle', 'Oui'),
          _buildRadioButtonCell('santeSexuelle', 'Non'),
          _buildTextFormFieldCell(
            'santeSexuelleForme',
            isSanteSexuelleActive ? '' : null,
            isRequired: isSanteSexuelleActive,
          ),
        ]),
        TableRow(children: [
          _buildTableCell('La sensibilisation contre les abus et violences'),
          _buildRadioButtonCell('sensibilisation', 'Oui'),
          _buildRadioButtonCell('sensibilisation', 'Non'),
          _buildTextFormFieldCell(
            'sensibilisationForme',
            isSensibilisationActive ? '' : null,
            isRequired: isSensibilisationActive,
          ),
        ]),
        TableRow(children: [
          _buildTableCell('L\'éducation environnementale'),
          _buildRadioButtonCell('educationEnvironnementale', 'Oui'),
          _buildRadioButtonCell('educationEnvironnementale', 'Non'),
          _buildTextFormFieldCell(
            'educationEnvironnementaleForme',
            isEducationEnvironnementaleActive ? '' : null,
            isRequired: isEducationEnvironnementaleActive,
          ),
        ]),
      ],
    );
  }

  Widget _buildRegulationsTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Relatifs', isHeader: true),
            _buildTableCell('Oui', isHeader: true),
            _buildTableCell('Non', isHeader: true),
          ],
        ),
        TableRow(children: [
          _buildTableCell('À la sécurité physique'),
          _buildRadioButtonCell('securitePhysique', 'Oui'),
          _buildRadioButtonCell('securitePhysique', 'Non'),
        ]),
        TableRow(children: [
          _buildTableCell('À la stigmatisation et la discrimination'),
          _buildRadioButtonCell('stigmatisation', 'Oui'),
          _buildRadioButtonCell('stigmatisation', 'Non'),
        ]),
        TableRow(children: [
          _buildTableCell('Aux harcèlements et abus sexuels'),
          _buildRadioButtonCell('harcelementAbus', 'Oui'),
          _buildRadioButtonCell('harcelementAbus', 'Non'),
        ]),
      ],
    );
  }

  Widget _buildTeachingTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Formés', isHeader: true),
            _buildTableCell('H', isHeader: true),
            _buildTableCell('F', isHeader: true),
            _buildTableCell('H+F', isHeader: true),
          ],
        ),
        TableRow(children: [
          _buildTableCell('Formés'),
          _buildTextFormFieldCell('formesH', '0'),
          _buildTextFormFieldCell('formesF', '0'),
          _buildTextFormFieldCell('formesHF', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Dont dispensés'),
          _buildTextFormFieldCell('dontDispensesH', '0'),
          _buildTextFormFieldCell('dontDispensesF', '0'),
          _buildTextFormFieldCell('dontDispensesHF', '0'),
        ]),
      ],
    );
  }

  Widget _buildSchoolParametersTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Année d\'études', isHeader: true),
            _buildTableCell('Nombre de Salles autorisées', isHeader: true),
            _buildTableCell('Nombre de salles', isHeader: true),
          ],
        ),
        TableRow(children: [
          _buildTableCell('1ère année'),
          _buildTextFormFieldCell('premiereAnneeAutorisees', '0'),
          _buildTextFormFieldCell('premiereAnneeSalles', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('2ème année'),
          _buildTextFormFieldCell('deuxiemeAnneeAutorisees', '0'),
          _buildTextFormFieldCell('deuxiemeAnneeSalles', '0'),
        ]),
        TableRow(children: [
          _buildTableCell('Total'),
          _buildTextFormFieldCell('totalAutorisees', '0'),
          _buildTextFormFieldCell('totalSalles', '0'),
        ]),
      ],
    );
  }

  Widget _buildChildrenEffectivesTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            _buildTableCell('Niveau d\'études / Sexe / Age', isHeader: true),
            _buildTableCell('G', isHeader: true),
            _buildTableCell('F', isHeader: true),
          ],
        ),
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

  Widget _buildTextFormFieldCell(String key, String? initialValue, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        initialValue: initialValue ?? '',
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        onSaved: (value) => widget.formData[key] = value,
        validator: isRequired
            ? (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null
            : null,
      ),
    );
  }

  Widget _buildRadioButtonCell(String groupKey, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<String>(
          value: value,
          groupValue: widget.formData[groupKey]?.toString(),
          onChanged: (String? newValue) {
            setState(() {
              widget.formData[groupKey] = newValue;
              // Update the active state based on the radio button selection
              if (groupKey == 'vihSida') {
                isVihSidaActive = newValue == 'Oui';
              } else if (groupKey == 'santeSexuelle') {
                isSanteSexuelleActive = newValue == 'Oui';
              } else if (groupKey == 'sensibilisation') {
                isSensibilisationActive = newValue == 'Oui';
              } else if (groupKey == 'educationEnvironnementale') {
                isEducationEnvironnementaleActive = newValue == 'Oui';
              }
            });
          },
        ),
        Text(value),
      ],
    );
  }

  Widget _buildYesNoField(String groupKey, String yesValue, String noValue) {
    return Row(
      children: [
        Radio<String>(
          value: yesValue,
          groupValue: widget.formData[groupKey]?.toString(),
          onChanged: (String? value) {
            setState(() {
              widget.formData[groupKey] = value;
            });
          },
        ),
        Text(yesValue),
        SizedBox(width: 20),
        Radio<String>(
          value: noValue,
          groupValue: widget.formData[groupKey]?.toString(),
          onChanged: (String? value) {
            setState(() {
              widget.formData[groupKey] = value;
            });
          },
        ),
        Text(noValue),
      ],
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
      initialValue: initialValue ?? '',
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}