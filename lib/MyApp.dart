import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tera/a_storage/local_storage.dart';

import 'helper/get_binding.dart';
import 'helper/language/Translation.dart';
import 'screens/splash_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.onlyBuilder,
      defaultTransition: Transition.size,
      transitionDuration: Duration(milliseconds: 500),
      initialBinding: GetBinding(),
      translations: Translation(),
      locale: Locale('en'),
      fallbackLocale: Locale('en'),
      theme: ThemeData(
        // fontFamily: 'Crimson',
        primaryColor: LocalStorage().primaryColor(),
        accentColor: LocalStorage().primaryColor(),
      ),
      home: SplashScreen(),
    );
  }
}
