import 'package:flutter/material.dart';
import 'package:flutter_app/helper/language/Translation.dart';
import 'package:flutter_app/screens/start_up_screens/splash_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
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
      smartManagement: SmartManagement.onlyBuilder,
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
