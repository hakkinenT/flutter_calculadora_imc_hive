import 'package:flutter/material.dart';

SnackBar successSnackBar(String message) {
  return _customSnackBar(
      message: message,
      backgroundColor: Colors.green.shade200,
      textColor: Colors.black);
}

SnackBar errorSnackBar(String message) {
  return _customSnackBar(
      message: message,
      backgroundColor: Colors.red.shade200,
      textColor: Colors.black);
}

SnackBar _customSnackBar(
    {required String message,
    required Color backgroundColor,
    Color? textColor}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: TextStyle(
          color: textColor, fontWeight: FontWeight.w500, letterSpacing: 0.9),
    ),
    backgroundColor: backgroundColor,
  );
}
