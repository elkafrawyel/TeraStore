import 'package:flutter/material.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'auth/login_screen.dart';
import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isLangChecked =
        LocalStorage().getBool(LocalStorage.isLanguageChecked);
    final bool isPhoneVerifies =
        LocalStorage().getBool(LocalStorage.phoneVerified);
    final bool isLoggedIn = LocalStorage().getBool(LocalStorage.loginKey);

    return SplashScreenView(
      home: isLangChecked
          ? isLoggedIn && isPhoneVerifies
              ? HomeScreen()
              : LoginScreen()
          : LanguageScreen(),
      duration: 3000,
      imageSize: 250,
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
