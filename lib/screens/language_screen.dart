import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

import 'control_view.dart';
import 'custom_widgets/button/custom_button.dart';
import 'custom_widgets/menus/custom_language_menu.dart';

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
                    colorBackground: Get.find<MainController>().primaryColor,
                    colorText: Colors.white,
                    text: 'continueToHome'.tr,
                    onPressed: () {
                      Get.offAll(ControlView());
                      LocalStorage()
                          .setBool(LocalStorage.isLanguageChecked, true);
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
