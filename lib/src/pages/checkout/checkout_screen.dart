import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/components/card/card_price.dart';
import 'package:lojateamodas/src/components/card/cpf_field.dart';
import 'package:lojateamodas/src/components/checkout/credit_card_widget.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/models/order/order_model.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class CheckoutScreen extends StatefulWidget {
  final OrderModel? order;

  const CheckoutScreen({Key? key, this.order}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UtilsServices utilsServices = UtilsServices();
  //final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        title: Text(
          'Realize o Pagamento do seu Pedido!!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: CustomColors.customSwatchColor,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    'Pagamento Com Cartão de crédito',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                //cartao de credito
                const CreditCardWidget(),

                //campo cpf
                const CpfField(),
                const SizedBox(
                  height: 10,
                ),
                //Resumo do Pedido
                const Padding(
                  padding: EdgeInsets.only(
                      bottom: 10, left: 14.0, right: 14.0, top: 1),
                  child: PriceCard(),
                ),

                //Botão Pagar com o Cartão
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: CustomColors.customSwatchColor.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          // print('enviar');
                        }
                      },
                      child: const Text('Pagar com Cartão de Crédito'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 30,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      return TextButton.icon(
                        onPressed: (controller.isCheckoutLoading ||
                                controller.cartItems.isEmpty)
                            ? null
                            : () async {
                                bool? result = await showOrderConfirmation();

                                if (result ?? false) {
                                  controller.checkoutCart();
                                } else {
                                  utilsServices.showToast(
                                    message: 'Pedido não confirmado',
                                  );
                                }
                                // print(result);
                              },
                        icon: const Icon(
                          Icons.api_sharp,
                        ),
                        label: controller.isCheckoutLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Pagar com PIX',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Não',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Sim',
              ),
            ),
          ],
        );
      },
    );
  }
}
