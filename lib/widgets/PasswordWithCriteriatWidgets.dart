import 'package:flutter/material.dart';

class PasswordWithCriteriatWidgets extends StatefulWidget {
  final bool isPassword;
  final String label;
  final TextEditingController ctrl;
  final TextInputType type;
  final bool required;

  PasswordWithCriteriatWidgets({
    Key? key,
    this.isPassword = false,
    this.label = "",
    required this.ctrl,
    this.type = TextInputType.text,
    this.required = false,
  }) : super(key: key);

  @override
  _PasswordWithCriteriatWidgetsState createState() =>
      _PasswordWithCriteriatWidgetsState();
}

class _PasswordWithCriteriatWidgetsState
    extends State<PasswordWithCriteriatWidgets> {
  bool isPasswordVisible = false;
  bool isUpperCasePresent = false;
  bool isSpecialCharPresent = false;
  bool isLowerCasePresent = false;
  bool isNumberPresent = false;
  bool isTextEntered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextFormField(
            obscureText: !isPasswordVisible,
            controller: widget.ctrl,
            keyboardType: widget.type,
            onChanged: (value) {
              setState(() {
                isTextEntered = value.isNotEmpty;
                isUpperCasePresent = value.contains(RegExp(r'[A-Z]'));
                isSpecialCharPresent =
                    value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                isLowerCasePresent = value.contains(RegExp(r'[a-z]'));
                isNumberPresent = value.contains(RegExp(r'[0-9]'));
              });
            },
            validator: (String? value) {
              if (!widget.required) return null;
              if (value == null || value.isEmpty) {
                return "${widget.label} is required";
              }
              if (!isValidPassword(value)) {
                return "Invalid Password!";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: "Enter your ${widget.label}",
              border: _buildBorder(Colors.grey),
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
              enabledBorder: _buildBorder(Colors.grey),
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
          if (isTextEntered)
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    _buildCriteriaItem(
                      isUpperCasePresent,
                      "Uppercase",
                      Icons.check_circle,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    _buildCriteriaItem(
                      isSpecialCharPresent,
                      "Special Character",
                      Icons.check_circle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildCriteriaItem(
                      isLowerCasePresent,
                      "Lowercase",
                      Icons.check_circle,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    _buildCriteriaItem(
                      isNumberPresent,
                      "Number",
                      Icons.check_circle,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCriteriaItem(
      bool isCriteriaFulfilled, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: isCriteriaFulfilled ? Colors.green : Colors.grey,
            size: 16,
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isCriteriaFulfilled ? Colors.green : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: color),
    );
  }

  bool isValidPassword(String value) {
    if (value.length < 8) return false;

    if (!value.contains(RegExp(r'[A-Z]'))) return false;

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;

    if (!value.contains(RegExp(r'[a-z]'))) return false;

    if (!value.contains(RegExp(r'[0-9]'))) return false;

    return true;
  }
}