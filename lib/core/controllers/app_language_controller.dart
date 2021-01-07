import 'package:flutter/material.dart';
import 'package:flutter_app/helper/language/language_model.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

class AppLanguageController extends GetxController {
  var appLocaleCode = Get.deviceLocale.languageCode;

  var languageList = LanguageData.languageList();

  @override
  void onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();
    appLocaleCode = await localStorage.getLanguage() == null
        ? Get.deviceLocale.languageCode
        : await localStorage.getLanguage();
    Get.updateLocale(Locale(appLocaleCode));

    update();
  }

  LanguageData getSelectedLanguage() {
    LanguageData lang;
    languageList.forEach((element) {
      if (element.languageCode == appLocaleCode) {
        lang = element;
        return;
      }
    });
    return lang;
  }

  changeLanguage(String languageCode) async {
    LocalStorage localStorage = LocalStorage();
    if (appLocaleCode == languageCode) {
      return;
    }
    if (languageCode == 'ar') {
      appLocaleCode = 'ar';
      localStorage.setLanguage('ar');
    } else {
      appLocaleCode = 'en';
      localStorage.setLanguage('en');
    }
    update();
  }
}
