import 'package:flutter/material.dart';

Widget buildTextFormField({
  required BuildContext context,
  required String label,
  required String? initialValue,
  required FormFieldSetter<String> onSaved,
  FormFieldValidator<String>? validator,
  TextInputType? keyboardType,
  int? maxLines,
  IconData? icon,
  String? suffixText,
}) {
  return TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
      suffixText: suffixText,
      suffixStyle: TextStyle(color: Colors.grey.shade600),
    ),
    keyboardType: keyboardType,
    maxLines: maxLines,
    validator: validator,
    onSaved: onSaved,
  );
}

Widget buildDropdownFormField({
  required BuildContext context,
  required String label,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  IconData? icon,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade600) : null,
    ),
    items: items
        .map((item) => DropdownMenuItem(
      value: item,
      child: Text(item),
    ))
        .toList(),
    onChanged: onChanged,
    validator: (value) => value == null ? 'Champ obligatoire' : null,
    dropdownColor: Colors.white,
    borderRadius: BorderRadius.circular(12),
    icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
  );
}

Widget buildSummaryItem(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        const Text(': '),
        Expanded(
          child: Text(
            value ?? 'Non renseigné',
            style: TextStyle(
              color: value?.isEmpty ?? true ? Colors.grey : Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}