import 'package:get/get_navigation/get_navigation.dart';
import 'package:lojateamodas/src/pages/adress/adress_page.dart';

import 'package:lojateamodas/src/pages/auth/view/sign_up_screen.dart';
import 'package:lojateamodas/src/pages/auth/view/signi_in_screen.dart';
import 'package:lojateamodas/src/pages/base/binding/navigation_binding.dart';
import 'package:lojateamodas/src/pages/base/firebase/notification/binding/notification_bindings.dart';
import 'package:lojateamodas/src/pages/base/firebase/notification/screen/notification_screen.dart';
import 'package:lojateamodas/src/pages/base/screen/base_screen.dart';
import 'package:lojateamodas/src/pages/cart/binding/cart_binding.dart';
import 'package:lojateamodas/src/pages/cart/view/cart_tab.dart';
import 'package:lojateamodas/src/pages/checkout/checkout_screen.dart';
import 'package:lojateamodas/src/pages/home/binding/home_bindings.dart';
import 'package:lojateamodas/src/pages/home/product/product_screen.dart';

import 'package:lojateamodas/src/pages/orders/binding/orders_bindings.dart';
import 'package:lojateamodas/src/pages/orders/orders_tab.dart';
import 'package:lojateamodas/src/pages/profile/profile_tab.dart';
import 'package:lojateamodas/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.productRoute,
      page: () => ProductScreen(),
    ),
    GetPage(
      name: PagesRoutes.cartRoute,
      page: () => const CarTab(),
    ),
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SigninScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignupScreen(),
    ),
    GetPage(
      name: PagesRoutes.orders,
      page: () => const OrdersTab(),
    ),
    GetPage(
      name: PagesRoutes.profile,
      page: () => const ProfileTab(),
    ),
    GetPage(
      name: PagesRoutes.notification,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: PagesRoutes.checkout,
      page: () => const CheckoutScreen(),
    ),
    GetPage(
      name: PagesRoutes.addressRoute,
      page: () => const AddressPage(),
    ),
    GetPage(
        name: PagesRoutes.baseRoute,
        page: () => const BaseScreen(),
        bindings: [
          HomeBinding(),
          NavigationBindings(),
          CartBinding(),
          OrderBindings(),
          NotificationBinding(),
        ]),
  ];
}

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String productRoute = '/product';
  static const String addressRoute = '/address';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String cartRoute = '/cart';
  static const String orders = '/order';
  static const String profile = '/profile';
  static const String notification = '/notification';
  static const String checkout = '/checkout';
  static const String baseRoute = '/';
}
