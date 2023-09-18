import 'package:flutter_calculadora_imc/services/calculadora_imc.dart';

import '../models/imc.dart';

class IMCRepository {
  final List<IMC> _imcs = [];

  List<IMC> get imcs => _imcs;

  Future<void> addIMC(double peso, double altura) async {
    await Future.delayed(const Duration(seconds: 2));
    final classificacao = CalculadoraIMC.classificacao(peso, altura);
    final imc = IMC(peso: peso, altura: altura, classificacao: classificacao);

    _imcs.add(imc);
  }

  Future<void> removeIMC(IMC imc) async {
    await Future.delayed(const Duration(seconds: 2));
    _imcs.remove(imc);
  }
}
