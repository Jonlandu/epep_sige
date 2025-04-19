import 'package:flutter/material.dart';

class CapacityStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const CapacityStep({
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
            'Capacité d\'accueil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Indiquez la capacité de l\'établissement',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _buildCapacityFormField(),
        ],
      ),
    );
  }

  Widget _buildCapacityFormField() {
    return _buildTextFormField(
      label: 'Capacité d\'accueil *',
      initialValue: formData['capaciteAccueil'],
      keyboardType: TextInputType.number,
      onSaved: (value) => formData['capaciteAccueil'] = value,
      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
      icon: Icons.people_alt_outlined,
      suffixText: 'élèves',
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