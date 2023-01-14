import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/orders/controller/all_orders_controller.dart';

class OrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }
}
