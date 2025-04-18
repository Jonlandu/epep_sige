import 'package:flutter/material.dart';

class EntryFieldPasswordWidgets extends StatefulWidget {
  final bool isPassword;
  final String label;
  final TextEditingController ctrl;
  final TextInputType type;
  final bool required;

  EntryFieldPasswordWidgets({
    Key? key,
    this.isPassword = false,
    this.label = "",
    required this.ctrl,
    this.type = TextInputType.text,
    this.required = false,
  }) : super(key: key);

  @override
  _EntryFieldPasswordWidgetsState createState() =>
      _EntryFieldPasswordWidgetsState();
}

class _EntryFieldPasswordWidgetsState
    extends State<EntryFieldPasswordWidgets> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        obscureText: !isPasswordVisible,
        controller: widget.ctrl,
        keyboardType: widget.type,
        validator: (String? value) {
          if (!widget.required) return null;
          if (value == null || value.isEmpty) {
            return "${widget.label} is required";
          }
          if (!isValidPassword(value)) {
            return "Invalid Password. !";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: "Enter your ${widget.label}",
          border: _bordure(Colors.grey),
          fillColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          enabledBorder: _bordure(Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _bordure(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: color),
    );
  }

  bool isValidPassword(String value) {
    /*if (value.length < 8) return false;

    if (!value.contains(RegExp(r'[A-Z]'))) return false;

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;

    if (!value.contains(RegExp(r'[a-z]'))) return false;

    if (!value.contains(RegExp(r'[0-9]'))) return false;*/

    return true;
  }
}