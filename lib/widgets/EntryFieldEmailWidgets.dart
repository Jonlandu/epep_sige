import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

Widget EntryFieldEmailWidgets({
  bool isEmail = false,
  String label = "",
  required TextEditingController ctrl,
  TextInputType type = TextInputType.text,
  bool required = false,
}) {
  return Container(
    padding: EdgeInsets.zero,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: TextFormField(
      obscureText: isEmail,
      controller: ctrl,
      keyboardType: type,
      validator: (String? value) {
        if (!required) return null;
        if (value == null || value.isEmpty) {
          return "$label is required";
        }
        // if (!isEmail && !EmailValidator.validate(value)) {
        //   return "Invalid email address";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: "Enter your $label",
        border: _bordure(Colors.grey),
        fillColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange, width: 1.4),
        ),
        enabledBorder: _bordure(Colors.grey),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1.4),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
    ),
  );
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: _color),
  );
}
