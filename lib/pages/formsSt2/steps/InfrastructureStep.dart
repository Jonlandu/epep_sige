import 'package:flutter/material.dart';

class InfrastructureStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const InfrastructureStep({
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
                title: "Infrastructure",
                children: [
                  _buildInformationCheckBox('2.10. Les locaux, sont-ils utilisés par un 2ème établissement', 'locauxUtilises'),
                  _buildInformationCheckBox('2.11. D\'un point d\'eau', 'pointEau'),
                  _buildInformationCheckBox('2.12. De sources d\'énergies', 'sourcesEnergie'),
                  _buildInformationCheckBox('2.13. Des latrines (W.C)', 'latrines'),
                  _buildTextFormField(
                    label: '2.14. Nombre de compartiments',
                    initialValue: formData['compartiments'],
                    onSaved: (value) => formData['compartiments'] = value,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextFormField(
                    label: '2.15. Dont pour les filles',
                    initialValue: formData['compartimentsFilles'],
                    onSaved: (value) => formData['compartimentsFilles'] = value,
                    validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
                    keyboardType: TextInputType.number,
                  ),
                  _buildInformationCheckBox('2.16. Une cour de récréation', 'courRecreation'),
                  _buildInformationCheckBox('2.17. Un terrain de sport', 'terrainSport'),
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
          'Infrastructure de l\'établissement',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Veuillez fournir les informations concernant l\'infrastructure',
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