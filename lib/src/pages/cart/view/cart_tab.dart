import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';
import 'package:lojateamodas/src/pages/home/view/components/cart_tile.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';
// ignore: library_prefixes

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                //Lista dos items do carrinho
                Expanded(
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      if (controller.cartItems.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.remove_shopping_cart,
                              size: 40,
                              color: CustomColors.customSwatchColor,
                            ),
                            const Text('Não há items no carrinho'),
                          ],
                        );
                      }
                      return ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (_, index) => CartTile(
                          cartItem: controller.cartItems[index],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.shade300,
                        blurRadius: 3,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Total geral:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: GetBuilder<CartController>(
                          builder: (controller) {
                            return Text(
                              utilsServices
                                  .priceToCurrency(controller.cartTotalPrice()),
                              style: TextStyle(
                                fontSize: 23,
                                color: CustomColors.customSwatchColor,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      //        SizedBox(
                      //          height: 40,
                      //          child: GetBuilder<CartController>(
                      //            builder: (controller) {
                      //              return ElevatedButton(
                      //                style: ElevatedButton.styleFrom(
                      //                  primary: CustomColors.customSwatchColor,
                      //                  shape: RoundedRectangleBorder(
                      //                    borderRadius: BorderRadius.circular(18),
                      //                  ),
                      //                ),
                      //                onPressed: (controller.isCheckoutLoading ||
                      //                        controller.cartItems.isEmpty)
                      //                    ? null
                      //                    : () async {
                      //                        bool? result =
                      //                            await showOrderConfirmation();
//
                      //                        if (result ?? false) {
                      //                          cartController.checkoutCart();
                      //                        } else {
                      //                          utilsServices.showToast(
                      //                            message: 'Pedido não confirmado',
                      //                          );
                      //                        }
                      //                        // print(result);
                      //                      },
                      //                child: controller.isCheckoutLoading
                      //                    ? const CircularProgressIndicator()
                      //                    : const Text(
                      //                        'Concluir Pedido',
                      //                        style: TextStyle(
                      //                          fontSize: 18,
                      //                        ),
                      //                      ),
                      //              );
                      //            },
                      //          ),
                      //        ),
                      ElevatedButton(
                        onPressed: () => Get.offNamed(
                          PagesRoutes.addressRoute,
                        ),
                        child: const Text('Continuar para Entrega'),
                      ),
                    ],
                  ),
                )
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
