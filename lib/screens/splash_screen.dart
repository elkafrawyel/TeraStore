import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/screens/control_view.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'language_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        builder: (controller) => SplashScreenView(
              home: LocalStorage().getBool(LocalStorage.isLanguageChecked)
                  ? ControlView()
                  : LanguageScreen(),
              duration: 3000,
              imageSize: 250,
              imageSrc: 'src/images/logo.png',
              text: 'labelWelcome'.tr,
              textType: TextType.TyperAnimatedText,
              textStyle: TextStyle(
                fontSize: 18,
              ),
              backgroundColor: Colors.white,
            ));
  }
}
