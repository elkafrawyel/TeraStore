import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/menus/custom_language_menu.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

import 'auth/login_screen.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'src/images/logo.png',
                  width: 200,
                  height: 200,
                ),
                CustomText(
                  alignment: AlignmentDirectional.center,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  text: 'appName'.tr,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  fontSize: 16,
                  alignment: AlignmentDirectional.center,
                  text: 'chooseLanguageMessage'.tr,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomLanguageMenu(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: CustomButton(
                    colorBackground: LocalStorage().primaryColor(),
                    colorText: Colors.white,
                    text: 'continueToHome'.tr,
                    onPressed: () async {
                      LocalStorage()
                          .setBool(LocalStorage.isLanguageChecked, true);
                      LocalStorage().getBool(LocalStorage.loginKey)
                          ? Get.offAll(HomeScreen())
                          : Get.offAll(LoginScreen());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
