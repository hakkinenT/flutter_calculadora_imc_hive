import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/utils/constants.dart';

class PurpleLinearProgressIndicator extends StatelessWidget {
  const PurpleLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      color: appColor,
    );
  }
}
