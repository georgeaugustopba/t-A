import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';

class CpfField extends StatelessWidget {
  const CpfField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 32,
        right: 32,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CPF',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: CustomColors.customSwatchColor,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '000.000.000-00',
                  isDense: true,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: (cpf) {
                  if (cpf!.isEmpty) {
                    return 'Campo Obrigatório';
                  } else if (cpf.length != 14) {
                    return 'CPF INVÁLIDO';
                  } else if (!CPFValidator.isValid(cpf)) {
                    return 'CPF INVÁLIDO';
                  }
                  return null;
                },
                onSaved: (value) {
                  authController.user.cpf = value;
                  // print(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
