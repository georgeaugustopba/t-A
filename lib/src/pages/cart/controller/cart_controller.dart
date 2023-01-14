import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/models/adress/adress.dart';
import 'package:lojateamodas/src/models/cart/cart_item_model.dart';
import 'package:lojateamodas/src/models/item/item_model.dart';
import 'package:lojateamodas/src/models/order/order_model.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages/cart/result/cart_result.dart';
import 'package:lojateamodas/src/pages/cart/view/repository/cart_repository.dart';
import 'package:lojateamodas/src/pages/widgets/payment_dialog.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  Adress? adress;

  bool isCheckoutLoading = false;

  int cartItemsQuantity() =>
      cartItems.map((e) => e.quantity).fold(0, (a, b) => a + b);

  bool get isCheckoutValid => cartItemsQuantity() >= 12;

  @override
  void onInit() {
    super.onInit();

    getCartItems();
    getCartTotalItems();
    // cartRepository.consultarCep;
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    if (!isCheckoutValid) {
      utilServices.showToast(
        message: 'A quantidade mínima é de 12 produtos!',
        isError: true,
      );
      return;
    }
    setCheckoutLoading(true);

    CartResult<OrderModel> result = await cartRepository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );
    setCheckoutLoading(false);

    result.when(
      success: (order) {
        cartItems.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (_) => PaymentDialog(
            order: order,
          ),
        );
      },
      error: (message) {
        utilServices.showToast(
          message: message,
        );
      },
    );
  }

  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );
    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }

      update();
    } else {
      utilServices.showToast(
        message: 'Ocorreu um erro ao alterar a quantidade do produto',
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );
    result.when(
      success: (data) {
        cartItems = data;
        update();
        // print(data);
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  int getItemIndex(ItemModel item) {
    // ignore: non_constant_identifier_names
    return cartItems.indexWhere((ItemInList) => ItemInList.item.id == item.id);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];

      await changeItemQuantity(
          item: product, quantity: (product.quantity + quantity));
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
    }

    update();
  }
}
