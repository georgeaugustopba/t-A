import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/base/firebase/custom_firebase.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomFirebaseController());
  }
}
