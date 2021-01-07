import 'package:firebase_auth/firebase_auth.dart';
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
    return


    //   Container(
    //   color: Colors.white,
    //   child: Center(
    //     child: CustomButton(
    //       text: 'Go',
    //       onPressed: () {
    //         Get.to(LoginScreen());
    //       },
    //     ),
    //   ),
    // );

    SplashScreenView(
    home: _getDestination(),
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

  _getDestination() {
    return LocalStorage().getBool(LocalStorage.isLanguageChecked)
        ? FirebaseAuth.instance.currentUser == null
            ? LoginScreen()
            : HomeScreen()
        : LanguageScreen();
  }
}
