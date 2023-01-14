import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/components/drawer/custom_drawer.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(246, 149, 197, 0.965),
                  Color.fromRGBO(241, 208, 224, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomDrawerHelder(),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shop),
                title: const Text('Loja'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Pedidos'),
                onTap: () {
                  Get.toNamed(PagesRoutes.orders);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Perfil'),
                onTap: () {
                  Get.toNamed(PagesRoutes.profile);
                },
              ),
              const Divider(),
              // if (authController.user.isAdmin)
              //   ListTile(
              //     leading: const Icon(Icons.edit),
              //     title: const Text('Usuários'),
              //     onTap: () {
              //       Get.toNamed(PagesRoutes.profile);
              //     },
              //   ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Sair'),
                onTap: () {
                  Get.toNamed(PagesRoutes.signInRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
