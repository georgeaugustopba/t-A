import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/models/item/item_model.dart';
import 'package:lojateamodas/src/pages/cart/controller/cart_controller.dart';
import 'package:lojateamodas/src/pages/home/controller/navigator_controller.dart';
import 'package:lojateamodas/src/pages/widgets/quantity_widget.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    Key? key,
  }) : super(key: key);

  final ItemModel item = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  int cartIemQuantity = 1;

  final cartController = Get.find<CartController>();
  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.network(
                    widget.item.imgUrl,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //nome
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.item.itemName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //quantidade
                              QuantityWidget(
                                result: (quantity) {
                                  setState(() {
                                    cartIemQuantity = quantity;
                                  });
                                },
                                value: cartIemQuantity,
                                suffixText: widget.item.unit,
                              ),
                            ],
                          ),

                          //preço
                          Text(
                            utilsServices.priceToCurrency(
                              widget.item.price,
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.customSwatchColor,
                            ),
                          ),

                          //Descrição
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  widget.item.description,
                                  style: const TextStyle(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //Botao
                          SizedBox(
                            height: 50,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {
                                //Fechar a tela
                                Get.back();

                                cartController.addItemToCart(
                                  item: widget.item,
                                  quantity: cartIemQuantity,
                                );
                                //carrinho
                                navigationController
                                    .navigatePageView(NavigationTabs.cart);
                              },
                              label: const Text(
                                'Comprar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //botao voltar
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
          //   Positioned(
          //     top: 20,
          //     right: 10,
          //     child: SafeArea(
          //       child: IconButton(
          //         onPressed: () => Get.offNamed(
          //           PagesRoutes.cartRoute,
          //         ),
          //         icon: const Icon(
          //           Icons.edit,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
