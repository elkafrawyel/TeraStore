import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tera/a_repositories/user_repo.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/models/user_model.dart';
import 'package:tera/data/requests/edit_profile_request.dart';
import 'package:tera/helper/language/language_model.dart';

class MainController extends GetxController {
  Color primaryColor = LocalStorage().primaryColor();

  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> empty = ValueNotifier(false);

  UserModel user;
  PickedFile selectedImage;

  var appLocaleCode = Get.deviceLocale.languageCode;

  var languageList = LanguageData.languageList();

  @override
  void onInit() {
    super.onInit();
    LocalStorage localStorage = LocalStorage();
    appLocaleCode = localStorage.getLanguage();
    Get.updateLocale(Locale(appLocaleCode));
    update();
  }

  changeAppColor(Color pickedColor) {
    LocalStorage().setInt(LocalStorage.selectedColorValue, pickedColor.value);
    primaryColor = pickedColor;
    update();
  }

  //===================== User ===========================

  loadUserData() async {
    bool isLoggedIn = LocalStorage().getBool(LocalStorage.loginKey);

    if (isLoggedIn) {
      await UserRepo().profile();
    }

    update();
    print(user);
  }

  setUserImage(PickedFile image) {
    selectedImage = image;
    update();
  }

  editProfile({String name, String email, String phone}) async {
    loading.value = true;
    update();
    user.name = name;
    user.email = email;
    user.phone = phone;
    await UserRepo().editProfile(
        EditProfileRequest(name: name, email: email, phone: phone),
        imagePath: selectedImage != null ? selectedImage.path : null);
    loading.value = false;
    Get.back();
    update();
  }

  logOut() async {
    await UserRepo().logOut();
  }

  //=================== Language =======================

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

//===========================================
}
