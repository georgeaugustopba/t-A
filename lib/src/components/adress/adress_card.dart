import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/components/adress/cep_input_field.dart';
import 'package:lojateamodas/src/components/adress/adress_input_field.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 800,
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: GetBuilder<CartController>(
              builder: (controller) {
                final adress = controller.adress;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Endereço de Entrega',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          CepInputField(adress: adress),
                          AdressInputAdress(adress: adress),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
