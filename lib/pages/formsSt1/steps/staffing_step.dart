import 'package:flutter/material.dart';

class StaffingStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const StaffingStep({
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
          _buildTitle(),
          const SizedBox(height: 8),
          _buildSubtitle(),
          const SizedBox(height: 24),
          _buildStaffingFields(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Effectifs',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade800,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Renseignez les nombres d\'élèves et enseignants',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildStaffingFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextFormField(
            label: 'Nombre d\'élèves *',
            initialValue: formData['nombreEleves'],
            keyboardType: TextInputType.number,
            onSaved: (value) => formData['nombreEleves'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.school_outlined,
            suffixText: 'élèves',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextFormField(
            label: 'Nombre d\'enseignants *',
            initialValue: formData['nombreEnseignants'],
            keyboardType: TextInputType.number,
            onSaved: (value) => formData['nombreEnseignants'] = value,
            validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
            icon: Icons.person_outline,
            suffixText: 'enseignants',
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    required TextInputType keyboardType,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    IconData? icon,
    String? suffixText,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
        suffixText: suffixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}