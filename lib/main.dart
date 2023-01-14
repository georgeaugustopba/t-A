import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/auth/controller/auth_controller.dart';
import 'package:lojateamodas/src/pages_route/app_pages.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());

  setPathUrlStrategy();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorTheme = Color.fromRGBO(255, 0, 128, 1);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T&A Moda Feminina',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: colorTheme,
        ),
        primaryColor: colorTheme,
        primarySwatch: Colors.pink,
        // scaffoldBackgroundColor: Colors.pink.shade100,
      ),
      getPages: AppPages.pages,
      initialRoute: PagesRoutes.splashRoute,
    );
  }
}
