import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/models/adress/adress.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';

class CepInputField extends StatelessWidget {
  CepInputField({Key? key, this.adress}) : super(key: key);

  final Adress? adress;

  final TextEditingController txtcep = TextEditingController();

  //String? cep;
  final TextEditingController cepController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String cep = txtcep.text;

    //if (adress.zipCode!.isEmpty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
            controller: txtcep,
            decoration: const InputDecoration(
              isDense: true,
              labelText: 'CEP',
              hintText: '12.345-678',
            ),
            validator: (cep) {
              if (cep!.isEmpty) {
                return 'Campo Obrigatório';
              } else if (cep.length != 10) {
                return 'Cep Inválido';
              }
              return null;
            },
            onChanged: (text) => cep = text,
            onSaved: (value) {
              adress!.cep = value!;
              print(value);
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(),
            ]),
        const SizedBox(
          height: 10,
        ),
        GetBuilder<CartController>(
          builder: (cartController) {
            return ElevatedButton(
              onPressed: () {
                cartController.cartRepository.consultarCep(cep);
                //   if (Form.of(context)!.validate()) {
                //     Form.of(context)!.save();

                //     // cartController.cartRepository.getAddress(cep);
                //   }
              },
              child: const Text('Buscar Cep '),
            );
          },
        ),
      ],
    );
//    } else {
//      return Row(
//        children: [
//          Expanded(
//            child: Text(
//              'CEP: ${adress.zipCode}',
//              style: TextStyle(
//                color: CustomColors.customSwatchColor,
//                fontWeight: FontWeight.w600,
//              ),
//            ),
//          ),
//        ],
//      );
//    }
  }
}
