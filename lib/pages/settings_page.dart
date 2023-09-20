import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/utils/constants.dart';

import '../models/imc.dart';
import '../repositories/imc_repository.dart';
import '../repositories/imc_repository_sqlite_impl.dart';
import '../utils/form_field_validation.dart';
import '../utils/methods.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/height_setting_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController alturaController = TextEditingController();
  bool loading = false;
  bool isValid = true;
  String? messageValidation;
  double altura = 0.0;

  IMCRepository repository = IMCRepositorySqliteImpl();

  @override
  void initState() {
    super.initState();
    _getAltura();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: ListView(
        children: [
          if (loading) const LinearProgressIndicator(),
          HeightSettingItem(
            children: [
              CustomTextFormField(
                controller: alturaController,
                hintText: '${altura.toStringAsFixed(2)} m',
                suffixIcon: _AddAltura(
                  onPressed: _onAddAlturaPressed,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _getAltura() async {
    try {
      var response = await repository.getAltura();

      setState(() {
        altura = response;
      });
    } catch (e) {
      if (mounted) {
        showErrorMessage(
            context, "Houve um erro ao tentar obter os dados no banco!");
      }
    }
  }

  _onAddAlturaPressed() async {
    _validateHeight();

    if (isValid) {
      _showLoadingProgress();

      await _addAltura();
      await _getAltura();

      clearTextField(alturaController);
      _hideLoadingProgress();

      if (mounted) {
        showSuccessMessage(context, "Altura cadastrada com sucesso!");

        _goToImcPage(context);
      }
    } else {
      showErrorMessage(context, messageValidation!);

      _resetState();
    }
  }

  void _validateHeight() {
    setState(() {
      messageValidation =
          FormFieldValidation.alturaValidation(alturaController.text);
      if (messageValidation != null) {
        isValid = false;
      }
    });
  }

  void _showLoadingProgress() {
    setState(() {
      loading = true;
    });
  }

  Future<void> _addAltura() async {
    setState(() {
      altura = convertStringToDouble(alturaController.text);
    });

    try {
      await repository.addAltura(IMC(altura: altura));
    } catch (e) {
      if (mounted) {
        showErrorMessage(context, "Houve um erro ao tentar cadastar a Altura!");
      }
    }
  }

  void _hideLoadingProgress() {
    setState(() {
      loading = false;
    });
  }

  void _resetState() {
    setState(() {
      isValid = true;
    });
  }

  void _goToImcPage(BuildContext context) {
    Navigator.pop(context);
  }
}

class _AddAltura extends StatelessWidget {
  const _AddAltura({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.send_rounded,
          color: appColor,
        ));
  }
}
