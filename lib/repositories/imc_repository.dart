import '../models/imc.dart';

abstract interface class IMCRepository {
  Future<void> addAltura(IMC imc);
  Future<double> getAltura();
  Future<void> addIMC(IMC imc);
  Future<void> removeIMC(IMC imc);
  Future<List<IMC>> getIMCs();
}
