import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key}) : super(key: key);
  //final String? buttonText;
  //final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final UtilsServices utilsServices = UtilsServices();

    // final cartManager = context.watch<CartManager>();
    // final productsPrice = cartManager.productsPrice;
    // final deliveryPrice = cartManager.deliveryPrice;
    // final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: GetBuilder<CartController>(
            builder: (cartController) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Resumo do Pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.customSwatchColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Subtotal',
                    ),
                    Text(
                      utilsServices.priceToCurrency(
                        cartController.cartTotalPrice(),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                //     if (deliveryPrice != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Entrega'),
                    Text(
                      'Gratuita',
                    )
                  ],
                ),
                const Divider(),

                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: CustomColors.customSwatchColor,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      utilsServices.priceToCurrency(
                        cartController.cartTotalPrice(),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )),
    );
  }
}
