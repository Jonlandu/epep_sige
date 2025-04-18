import 'package:flutter/material.dart';

class CustomVisibilityWidget extends StatelessWidget {
  final bool visible;
  final Widget child;
  final VoidCallback onPressed;
  final Color cancelTextColor;
  final FontWeight cancelTextFontWeight;

  const CustomVisibilityWidget({
    Key? key,
    required this.visible,
    required this.child,
    required this.onPressed,
    this.cancelTextColor = Colors.red,
    this.cancelTextFontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          alignment: Alignment.centerRight,
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(
              fontSize: 15,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: child,
        ),
      ),
    );
  }
}