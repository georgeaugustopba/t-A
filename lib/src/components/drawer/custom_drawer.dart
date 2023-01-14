import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';

class CustomDrawerHelder extends StatelessWidget {
  const CustomDrawerHelder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 180,
      child: GetBuilder<AuthController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'T&A Moda \nFeminina',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Olá, ${controller.user.name ?? ''}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //  GestureDetector(
            ],
          );
        },
      ),
    );
  }
}
