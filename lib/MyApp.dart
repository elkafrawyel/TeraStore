import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/language/Translation.dart';
import 'package:flutter_app/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/get_binding.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GetBinding(),
      home: SplashScreen(),
      translations: Translation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      theme: ThemeData(
        // fontFamily: 'Crimson',
        primaryColor: Get.put(MainController(),permanent: true).primaryColor,
        accentColor: Get.find<MainController>().primaryColor,
      ),
    );
  }
}
