import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojateamodas/src/models/adress/adress.dart';

class AdressInputAdress extends StatelessWidget {
  const AdressInputAdress({
    Key? key,
    required this.adress,
  }) : super(key: key);

  final Adress? adress;

  @override
  Widget build(BuildContext context) {
    String? emptyValidator(String? text) =>
        text!.isEmpty ? 'Campo Obrigatório' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          //initialValue: adress!.rua,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Rua/Avenida:',
            hintText: 'Av.Brasil',
          ),
          validator: emptyValidator,
          onSaved: (t) => adress!.rua = t!,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                //initialValue: adress!.ddd,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Número:',
                  hintText: '123',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                validator: emptyValidator,
                onSaved: (t) => adress!.ddd = t!,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                //initialValue: adress!.complemento,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Complemento:',
                  hintText: 'Opcional',
                ),
                keyboardType: TextInputType.text,
                onSaved: (t) => adress!.complemento = t!,
              ),
            )
          ],
        ),
        TextFormField(
          //initialValue: adress!.bairro,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'Bairro:',
            hintText: 'Coqueiros',
          ),
          validator: emptyValidator,
          onSaved: (t) => adress!.bairro = t!,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                //initialValue: adress!.cidade,
                decoration: const InputDecoration(
                  isDense: true,
                  //    enabled: false,
                  labelText: 'Cidade:',
                  hintText: 'Florianópolis',
                ),
                validator: emptyValidator,
                onSaved: (t) => adress!.cidade = t!,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                autocorrect: false,
                enabled: false,
                //initialValue: adress!.estado,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'UF',
                  hintText: 'SC',
                  counterText: '',
                ),
                maxLength: 2,
                validator: (e) {
                  if (e!.isEmpty) {
                    return 'Campo Obrigatório';
                  } else if (e.length != 2) {
                    return 'Inválido';
                  }
                  return null;
                },
                onSaved: (t) => adress!.estado = t!,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            if (Form.of(context)!.validate()) {
              Form.of(context)!.save();

              // cartController.cartRepository.getAddress(cep);
            }
          },
          child: const Text('Calcular Frete'),
        )
      ],
    );
  }
}
