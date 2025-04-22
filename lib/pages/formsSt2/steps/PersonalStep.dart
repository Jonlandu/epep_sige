import 'package:flutter/material.dart';

class PersonnelStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const PersonnelStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildSection(
                title: "Personnel éducatif",
                children: [
                  _buildTextFormField(
                    label: '2.26. Enseignants formés (12 derniers mois)',
                    initialValue: formData['enseignantsFormes'],
                    onSaved: (value) => formData['enseignantsFormes'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
                  _buildTextFormField(
                    label: '2.27. Enseignants cotés positivement (E, TB, B)',
                    initialValue: formData['enseignantsCotes'],
                    onSaved: (value) => formData['enseignantsCotes'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
                  _buildTextFormField(
                    label: '2.28. Enseignants inspectés pédagogique C3',
                    initialValue: formData['enseignantsInspectes'],
                    onSaved: (value) => formData['enseignantsInspectes'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
                  _buildInformationCheckBox('2.29. Chef d\'Etablissement formé (12 derniers mois)', 'chefForme'),
                  _buildInformationCheckBox('2.30. Chef d\'Établissement coté Positivement', 'chefCotePositivement'),
                  _buildInformationCheckBox('2.31. Activités parascolaires cette année', 'activitesParascolaires'),
                  _buildInformationCheckBox('2.32. Unité Pédagogique (UP) opérationnelle', 'unitePedagogique'),
                  _buildInformationCheckBox('2.33. Gouvernement d\'Élèves opérationnel', 'gouvernementEleves'),
                  _buildTextFormField(
                    label: '2.34. PV de réunions (à vérifier)',
                    initialValue: formData['pvReunions'],
                    onSaved: (value) => formData['pvReunions'] = value,
                  ),
                  _buildInformationCheckBox('2.35. Manuel de procédure pour la gestion', 'manuelProcedure'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personnel éducatif de l\'établissement',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Veuillez fournir les informations concernant le personnel éducatif',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInformationCheckBox(String title, String key) {
    return InkWell(
      onTap: () {
        formData[key] = formData[key] == 'Oui' ? 'Non' : 'Oui';
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _buildCompactRadioOption(key, 'Oui'),
            const SizedBox(width: 6),
            _buildCompactRadioOption(key, 'Non'),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactRadioOption(String key, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: formData[key] == value
            ? (value == 'Oui' ? Colors.green.shade50 : Colors.red.shade50)
            : null,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: formData[key] == value
              ? (value == 'Oui' ? Colors.green : Colors.red)
              : Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Radio<String>(
              value: value,
              groupValue: formData[key],
              onChanged: (String? newValue) => formData[key] = newValue,
              activeColor: value == 'Oui' ? Colors.green : Colors.red,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: formData[key] == value
                  ? (value == 'Oui' ? Colors.green : Colors.red)
                  : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
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
      keyboardType: keyboardType,
    );
  }
}