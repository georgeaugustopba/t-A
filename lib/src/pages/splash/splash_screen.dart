import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages/widgets/app_name_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Get.find<AuthController>().validateToken();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            //  Image.asset(
            //    "assets/images/logo.png",
            //    fit: BoxFit.cover,
            //    width: 400,
            //    height: 400,
            //  ),
            AppNamedWidget(
              modasTitleColor: Colors.white,
              textSize: 35,
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
