import 'package:flutter/material.dart';

class DiversStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const DiversStep({
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
                title: "Divers",
                children: [
                  _buildInformationCheckBox('2.36. Plan de communication', 'planCommunication'),
                  _buildInformationCheckBox('2.37. Participation aux forums REP', 'forumsREP'),
                  _buildInformationCheckBox('2.38. Réseaux Locaux de Directeurs (RLD)', 'reseauDirecteurs'),
                  _buildInformationCheckBox('2.39. Chef d\'Établissement dans RLD', 'chefDansRLD'),
                  _buildInformationCheckBox('2.40. Des arbres', 'arbres'),
                  _buildTextFormField(
                    label: '2.41. Nombre d\'arbres plantés cette année',
                    initialValue: formData['arbresPlantes'],
                    onSaved: (value) => formData['arbresPlantes'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
                  _buildTextFormField(
                    label: '2.42. Enseignants formés sur 1er soin',
                    initialValue: formData['enseignantsPremierSoin'],
                    onSaved: (value) => formData['enseignantsPremierSoin'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
                  _buildInformationCheckBox('2.43. Coins de gestion de déchets', 'gestionDechets'),
                  _buildTextFormField(
                    label: '2.44. Femmes enseignantes recrutées cette année',
                    initialValue: formData['femmesEnseignantes'],
                    onSaved: (value) => formData['femmesEnseignantes'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
                  _buildTextFormField(
                    label: '2.45. Enseignants formés sur pédagogie sensible au genre',
                    initialValue: formData['formationGenre'],
                    onSaved: (value) => formData['formationGenre'] = value,
                    keyboardType: TextInputType.number,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                  ),
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
          'Informations Divers de l\'établissement',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Veuillez fournir les informations diverses',
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