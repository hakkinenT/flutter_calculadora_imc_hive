import 'package:flutter/material.dart';

import '../../models/imc.dart';
import '../../models/repositories/imc_repository.dart';
import '../../models/repositories/imc_repository_sqlite_impl.dart';
import '../../utils/form_field_validation.dart';
import '../../utils/methods.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/imc_item.dart';
import '../widgets/purple_linear_progress_indicator.dart';
import '../widgets/register_weight_dialog.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  TextEditingController pesoController = TextEditingController();

  bool loading = false;
  bool isValid = true;
  String? messageValidation;

  IMCRepository repository = IMCRepositorySqliteImpl();
  List<IMC> imcs = [];

  @override
  void initState() {
    super.initState();

    _getIMCs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        actions: [
          IconButton(
            onPressed: _onAddButtonPressed,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: loading
          ? const PurpleLinearProgressIndicator()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: imcs.length,
              itemBuilder: (context, index) {
                return IMCItem(
                  imc: imcs[index],
                  deleteFunction: () => _onDeleteButtonPressed(imcs[index]),
                );
              }),
    );
  }

  _getIMCs() async {
    _showLoadingProgress();

    try {
      imcs = await repository.getIMCs();
      _sortToDescendingOrder();
    } catch (e) {
      if (mounted) {
        showErrorMessage(context, "Houve um erro ao obter os dados no banco!");
      }
    }

    _hideLoadingProgress();
  }

  void _sortToDescendingOrder() {
    imcs.sort((a, b) => b.id!.compareTo(a.id!));
  }

  void _showLoadingProgress() => setState(() {
        loading = true;
      });

  void _hideLoadingProgress() => setState(() {
        loading = false;
      });

  void _onAddButtonPressed() {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return registerWeightDialog(context,
              content: CustomTextFormField(
                controller: pesoController,
                hintText: "50.0 kg",
              ),
              onCalcularPressed: _onCalcularButtonPressed);
        });
  }

  void _onCalcularButtonPressed() async {
    _validateWeight();

    if (isValid) {
      _showLoadingProgress();

      await _addIMC();
      await _getIMCs();

      if (mounted) {
        showSuccessMessage(context, "IMC cadastrado com sucesso!");
      }

      clearTextField(pesoController);

      _hideLoadingProgress();
    } else {
      showErrorMessage(context, messageValidation!);
      _resetState();
    }

    if (mounted) {
      _goBackToHomePage(context);
    }
  }

  void _validateWeight() {
    setState(() {
      messageValidation =
          FormFieldValidation.pesoValidation(pesoController.text);
      if (messageValidation != null) {
        isValid = false;
      }
    });
  }

  Future<void> _addIMC() async {
    double? peso;

    setState(() {
      peso = convertStringToDouble(pesoController.text);
    });

    try {
      await repository.addIMC(IMC(peso: peso));
    } catch (e) {
      if (mounted) {
        showErrorMessage(context, "Houve um erro ao tentar cadastrar o IMC!");
      }
    }
  }

  void _resetState() => setState(() {
        isValid = true;
      });

  void _goBackToHomePage(BuildContext context) {
    Navigator.pop(context);
  }

  void _onDeleteButtonPressed(IMC imc) async {
    _showLoadingProgress();

    await _deleteIMC(imc);
    await _getIMCs();

    if (mounted) {
      showSuccessMessage(context, "IMC removido com sucesso!");
    }

    _hideLoadingProgress();
  }

  Future<void> _deleteIMC(IMC imc) async {
    try {
      await repository.removeIMC(imc);
    } catch (e) {
      if (mounted) {
        showErrorMessage(context, 'Houve um erro ao tentar remover o IMC!');
      }
    }
  }
}
