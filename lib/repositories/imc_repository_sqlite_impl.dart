import '../models/imc.dart';
import '../services/altura_service.dart';
import '../services/imc_service.dart';
import '../utils/calculadora_imc.dart';
import 'imc_repository.dart';

class IMCRepositorySqliteImpl implements IMCRepository {
  final IMCService imcService = IMCService();
  final AlturaService alturaService = AlturaService();

  @override
  Future<void> addAltura(IMC imc) async {
    await alturaService.add(imc.altura!);
  }

  @override
  Future<void> addIMC(IMC imc) async {
    final altura = await getAltura();
    final classificacao = CalculadoraIMC.classificacao(imc.peso!, altura);

    await imcService.add(imc.peso!, classificacao);
  }

  @override
  Future<double> getAltura() async {
    return await alturaService.getOne();
  }

  @override
  Future<List<IMC>> getIMCs() async {
    final response = await imcService.getAll();
    final imcs = response.map((imc) => IMC.fromJson(imc)).toList();
    return imcs;
  }

  @override
  Future<void> removeIMC(IMC imc) async {
    await imcService.delete(imc.id!);
  }
}
