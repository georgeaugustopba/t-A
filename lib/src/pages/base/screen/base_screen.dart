import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages/cart/view/cart_tab.dart';
import 'package:lojateamodas/src/pages/home/controller/navigator_controller.dart';
import 'package:lojateamodas/src/pages/home/view/home_tab.dart';
import 'package:lojateamodas/src/pages/orders/orders_tab.dart';
import 'package:lojateamodas/src/pages/profile/profile_tab.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';

//sempre tenho que colocar a função fora de tudo e fazer a referencia dela no FirebaseMessaging.onBackgroundMessage
//Future<void> onBackgroundgroundMessage(RemoteMessage message) async {
////  print(message.data);
//}

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? token;

  final authController = Get.find<AuthController>();

  final navigationController = Get.find<NavigationController>();

  @override
  void initState() {
    super.initState();
    initializeForm();
    FirebaseMessaging.instance.requestPermission();
  }

  Future<void> initializeForm() async {
    token = await messaging.getToken();
    //print(token);
    //   setState(() {});

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        Flushbar(
          maxWidth: 700,
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(10),
          title: message.notification!.title,
          titleColor: Colors.black,
          messageColor: Colors.black,
          messageSize: 12,
          duration: const Duration(seconds: 5),
          message: message.notification!.body,
          flushbarPosition: FlushbarPosition.TOP,
          // backgroundColor: Colors.white,
          animationDuration: const Duration(seconds: 3),
          backgroundGradient: LinearGradient(colors: [
            Colors.pink.shade100,
            Colors.pink.shade500,
          ]),

          onTap: (_) {
            Get.offNamed(PagesRoutes.cartRoute);
            //print('toque em foreground ${message.data}');
          },
        ).show(context);
      }
    });
    //aqui recebo a notificação em background
    //FirebaseMessaging.onBackgroundMessage(onBackgroundgroundMessage);

    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Toque em background : ${message.notification?.title}');
    // });

    // final RemoteMessage? message = await messaging.getInitialMessage();
    // if (message != null) {
    //   print('Toque em termited2: ${message.notification?.title}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    final sizeTab = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomeTab(),
          CarTab(),
          OrdersTab(),
          ProfileTab(),

          // AdminPage(),
        ],
      ),
      bottomNavigationBar: sizeTab.width < 800
          ? Obx(
              () => BottomNavigationBar(
                onTap: (index) {
                  navigationController.navigatePageView(index);
                },
                currentIndex: navigationController.currentIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: CustomColors.customSwatchColor.shade700,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white.withAlpha(100),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: 'Carrinho',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Pedidos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Perfil',
                  ),
                  //  if (authController.user.isAdmin)
                  //    const BottomNavigationBarItem(
                  //      icon: Icon(Icons.production_quantity_limits),
                  //      label: 'Produtos',
                  //    ),
                ],
              ),
            )
          : null,
    );
  }
}
