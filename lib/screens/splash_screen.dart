import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/helper/messaging/push_notifications.dart';
import 'package:tera/screens/home_screen/home_screen.dart';

import 'auth/login_screen.dart';
import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PushNotificationsManager().init(context);
    final bool isLangChecked =
        LocalStorage().getBool(LocalStorage.isLanguageChecked);
    final bool isLoggedIn = LocalStorage().getBool(LocalStorage.loginKey);

    return SplashScreenView(
      home: isLangChecked
          ? isLoggedIn
              ? HomeScreen()
              : LoginScreen()
          : LanguageScreen(),
      duration: 3000,
      imageSize: 300,
      imageSrc: 'src/images/logo.png',
      text: 'labelWelcome'.tr,
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 18,
      ),
      backgroundColor: Colors.white,
    );
  }
}
