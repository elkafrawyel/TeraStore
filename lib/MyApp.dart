import 'package:flutter/material.dart';
import 'package:flutter_app/helper/language/Translation.dart';
import 'package:flutter_app/view/splash_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/Constant.dart';
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
      theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: primarySwatch,
          accentColor: accentColor),
      initialBinding: GetBinding(),
      home: SplashScreen(),
      translations: Translation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
    );
  }
}
