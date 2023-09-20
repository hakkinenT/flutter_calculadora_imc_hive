import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/custom_snack_bar.dart';

double convertStringToDouble(String text) => double.parse(text);

int convertStringToInt(String text) => int.parse(text);

void clearTextField(TextEditingController controller) => controller.clear();

void showSnackBar(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      snackBar,
    );
}

void showSuccessMessage(BuildContext context, String message) {
  showSnackBar(
    context,
    successSnackBar(message),
  );
}

void showErrorMessage(BuildContext context, String message) {
  showSnackBar(
    context,
    errorSnackBar(message),
  );
}
