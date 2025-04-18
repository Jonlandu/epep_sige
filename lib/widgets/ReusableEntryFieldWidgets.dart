import 'package:flutter/material.dart';

Widget ReusableEntryFieldWidgets(
    {bool isName = false,
    String label = "",
    required TextEditingController ctrl,
    TextInputType type = TextInputType.text,
    bool required = false}) {
  return Container(
    padding: EdgeInsets.zero,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16),
    /*decoration: BoxDecoration(
      color: Color(0xFFE7E6F4),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color(0xFFE7E6F4),
      ),

    ),*/
    child: TextFormField(
        obscureText: isName,
        controller: ctrl,
        keyboardType: type,
        validator: (String? value) {
          if (!required) return null;
          if (value == null || value.isEmpty) {
            return "$label is required";
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: label,
            hintText: "Enter your $label",
            border: _bordure(Colors.grey),
            fillColor: Colors.grey,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.orange),
            ),
          enabledBorder: _bordure(Colors.grey),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),)),
  );
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: _color),
  );
}
