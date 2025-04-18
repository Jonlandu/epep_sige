import 'package:flutter/material.dart';

Widget EntryFieldLongtext({
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
        controller: ctrl,
        //keyboardType: type,
        keyboardType: TextInputType.multiline,
        //maxLines: null,
        minLines: 1,
        maxLines: 10,
        validator: (value) {
          if (!required) return null;
          if (value == null || value.isEmpty) {
            return "Champs obligatoire";
          }
          return null;
        },
        /*decoration: InputDecoration(
            labelText: label,
            hintText: "Saisir...",
            border: _bordure(Colors.grey),
            focusedBorder: _bordure(Colors.orange),
            enabledBorder: _bordure(Colors.grey)),*/
      decoration: InputDecoration(
        labelText: label,
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
      borderRadius: BorderRadius.all(Radius.circular(0)));
}
