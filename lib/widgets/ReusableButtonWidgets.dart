import 'package:flutter/material.dart';

class ReusableButtonWidgets extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color color, textColor, borderColor;
  final TextStyle textStyle;
  final double fontSize, borderWidth;
  final FontWeight fontWeight; // New parameter for font weight

  const ReusableButtonWidgets({
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.textStyle = const TextStyle(),
    this.fontSize = 16.0,
    this.borderWidth = 0.0,
    this.fontWeight = FontWeight.normal, // Default font weight
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0.0, // Set elevation to 0.0 to remove the shadow
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        child: Text(
          text,
          style: textStyle.copyWith(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight, // Apply custom font weight
          ),
        ),
      ),
    );
  }
}