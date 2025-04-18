import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidgets{
  static showSnack(BuildContext context, String message, [Color color = Colors.red]) {
    final scaffold = ScaffoldMessenger.of(context);
    var snackbar = SnackBar(
      backgroundColor: color,
      content: Text(message),
    );
    scaffold.showSnackBar(snackbar);
  }


  static  launchAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("In progress..."),
        );
      },
    );
  }

}

class MessageWidgetsSuccess{
  static showSnack(BuildContext context, String message, [Color color = Colors.green]) {
    final scaffold = ScaffoldMessenger.of(context);
    var snackbar = SnackBar(
      backgroundColor: color,
      content: Text(message),
    );
    scaffold.showSnackBar(snackbar);
  }


  static  launchAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("In progress..."),
        );
      },
    );
  }

}