import 'package:flutter/material.dart';

class LocationStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const LocationStep({
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
                title: "Infrastructure de base",
                children: [
                  _buildInformationCheckBox('Des programmes officiels de cours ?', 'programmesOfficiels'),
                  _buildInformationCheckBox('D\'un COPA ?', 'copa'),
                  _buildInformationCheckBox('Les locaux, sont-ils utilisés par un 2ème ?', 'locauxUtilises'),
                  _buildInformationCheckBox('Point d\'eau existant ?', 'pointEauExistant'),
                  _buildInformationCheckBox('De sources d\'énergie ?', 'sourcesEnergie'),
                  _buildInformationCheckBox('Des latrines (W.C) ?', 'latrines'),
                  _buildInformationCheckBox('Une cour de récréation ?', 'courRecreation'),
                  _buildInformationCheckBox('Un terrain de jeux ?', 'terrainJeux'),
                ],
              ),
              const SizedBox(height: 12),
              _buildSection(
                title: "Gestion administrative",
                children: [
                  _buildInformationCheckBox('Une clôture ?', 'cloture'),
                  _buildInformationCheckBox('Est-il pris en charge par le Programme de réfugiés ?', 'programmeRefugies'),
                  _buildInformationCheckBox('Votre établissement a-t-il développé un projet d\'établissement avec toutes les parties prenantes ?', 'projetEtablissement'),
                  _buildInformationCheckBox('Votre établissement dispose-t-il de prévisions budgétaires et des documents comptables ?', 'previsionsBudgetaires'),
                  _buildInformationCheckBox('Votre établissement dispose-t-il d\'un plan d\'action opérationnel ?', 'planActionOperational'),
                ],
              ),
              const SizedBox(height: 12),
              _buildSection(
                title: "Performance et évaluation",
                children: [
                  _buildInformationCheckBox('Votre établissement a-t-il élaboré un Tableau de ?', 'tableauElabore'),
                  _buildInformationCheckBox('Votre établissement a-t-il organisé une Revue Annuelle de Performance (RAP) ?', 'revueAnnuelle'),
                ],
              ),
              const SizedBox(height: 12),
              _buildSection(
                title: "Personnel éducatif",
                children: [
                  _buildTextFormField(
                    label: 'Nombre d\'éducateurs formés (12 derniers mois)',
                    initialValue: formData['nombreEducateursFormation'],
                    onSaved: (value) => formData['nombreEducateursFormation'] = value,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    icon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: 'Nombre d\'éducateurs bien cotés (E, TB, B)',
                    initialValue: formData['nombreEducateursCotes'],
                    onSaved: (value) => formData['nombreEducateursCotes'] = value,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    icon: Icons.star_rate_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildTextFormField(
                    label: 'Nombre d\'éducateurs inspectés (C3)',
                    initialValue: formData['nombreEducateursInspection'],
                    onSaved: (value) => formData['nombreEducateursInspection'] = value,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    icon: Icons.assignment_turned_in_outlined,
                  ),
                  const SizedBox(height: 8),
                  _buildInformationCheckBox('Le Chef d\'établissement a-t-il reçu une formation continue 12 derniers mois ?', 'formationContinue'),
                  _buildInformationCheckBox('Le Chef d\'établissement a-t-il été coté Positivement ? (Reserve au S/PROVED)', 'chefCotePositivement'),
                ],
              ),
              const SizedBox(height: 20),
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
          'Localisation de l\'établissement',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Renseignez les informations géographiques et administratives',
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
        // Inversion de la valeur actuelle (si 'Oui' devient 'Non' et vice versa)
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