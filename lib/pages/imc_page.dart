import 'package:flutter/material.dart';
import 'package:flutter_calculadora_imc/models/imc.dart';

import '../repositories/imc_repository.dart';
import '../utils/form_field_validation.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/form_label.dart';
import '../widgets/imc_item.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  IMCRepository repository = IMCRepository();
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      body: loading
          ? const LinearProgressIndicator(
              color: Colors.purple,
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: repository.imcs.length,
              itemBuilder: (context, index) {
                final imcs = repository.imcs;
                return IMCItem(
                  imc: imcs[index],
                  deleteFunction: () => _onDeleteButtonPressed(imcs[index]),
                );
              }),
    );
  }

  void _onAddButtonPressed() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        builder: (context) {
          return _ModalBottomSheetBody(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(label: "Peso"),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(
                    controller: pesoController,
                    hintText: "50.0 kg",
                    validator: FormFieldValidation.pesoValidation,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const FormLabel(label: "Altura"),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormField(
                    controller: alturaController,
                    hintText: "1.50 m",
                    validator: FormFieldValidation.alturaValidation,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomElevatedButton(
                      onPressed: _onCalcularButtonPressed,
                      child: const Text("Calcular IMC")),
                ],
              ),
            ),
          );
        });
  }

  void _onCalcularButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      double peso = 0.0;
      double altura = 1.0;

      setState(() {
        peso = double.parse(pesoController.text);

        altura = double.parse(alturaController.text);
      });

      await repository.addIMC(peso, altura);

      pesoController.clear();
      alturaController.clear();

      setState(() {
        loading = false;
      });

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  void _onDeleteButtonPressed(IMC imc) async {
    setState(() {
      loading = true;
    });

    await repository.removeIMC(imc);

    setState(() {
      loading = false;
    });
  }
}

class _ModalBottomSheetBody extends StatelessWidget {
  const _ModalBottomSheetBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
