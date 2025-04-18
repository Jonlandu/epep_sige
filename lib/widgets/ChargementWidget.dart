import 'package:flutter/material.dart';

Widget ChargementWidget([bool isVisible = false]) {
  return Visibility(
    visible: isVisible,
    child: Builder(
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          ),
        );
      },
    ),
  );
}