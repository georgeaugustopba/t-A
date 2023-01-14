import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/home/controller/navigator_controller.dart';

class NavigationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}
