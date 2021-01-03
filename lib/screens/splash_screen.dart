import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/local_storage.dart';
import 'package:flutter_app/screens/control_view.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SplashScreenView(
            home: LocalStorage().getBool(LocalStorage.isLanguageChecked)
                ? ControlView()
                : LanguageScreen(),
            duration: 3000,
            imageSize: 250,
            imageSrc: 'src/images/logo.png',
            text: 'labelWelcome'.tr,
            textType: TextType.TyperAnimatedText,
            textStyle: TextStyle(
              fontSize: 20.0,
            ),
            backgroundColor: Colors.white,
          )),
    );
  }
}
