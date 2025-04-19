import 'package:flutter/material.dart';
import '../widgets/form_widgets.dart';

class ContactStep extends StatelessWidget {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  const ContactStep({
    super.key,
    required this.formData,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,  // Utilisation de formKey passé en paramètre
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 8),
          _buildSubtitle(),
          const SizedBox(height: 24),
          _buildAddressField(),
          const SizedBox(height: 20),
          _buildPhoneField(),
          const SizedBox(height: 20),
          _buildEmailField(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Coordonnées',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.pink.shade800,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'Comment contacter l\'établissement',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.shade600,
      ),
    );
  }

  Widget _buildAddressField() {
    return _buildTextFormField(
      label: 'Adresse complète *',
      initialValue: formData['adresse'],
      maxLines: 2,
      keyboardType: TextInputType.text,  // Ajout de keyboardType
      onSaved: (value) => formData['adresse'] = value,
      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
      icon: Icons.home_outlined,
    );
  }

  Widget _buildPhoneField() {
    return _buildTextFormField(
      label: 'Téléphone *',
      initialValue: formData['telephone'],
      keyboardType: TextInputType.phone,
      onSaved: (value) => formData['telephone'] = value,
      validator: (value) => value?.isEmpty ?? true ? 'Champ obligatoire' : null,
      icon: Icons.phone_outlined,
    );
  }

  Widget _buildEmailField() {
    return _buildTextFormField(
      label: 'Email',
      initialValue: formData['email'],
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => formData['email'] = value,
      validator: (value) {
        if (value?.isNotEmpty ?? false) {
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
            return 'Email invalide';
          }
        }
        return null;
      },
      icon: Icons.email_outlined,
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? initialValue,
    int? maxLines,
    required TextInputType keyboardType,  // Assurez-vous que ce paramètre est requis
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
    IconData? icon,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: keyboardType,
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