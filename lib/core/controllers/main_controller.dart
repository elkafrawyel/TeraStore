import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/helper/language/language_model.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/start_up_screens/auth/login_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'cart_controller.dart';

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
    appLocaleCode = localStorage.getLanguage() == null
        ? Get.deviceLocale.languageCode
        : localStorage.getLanguage();
    Get.updateLocale(Locale(appLocaleCode));
    update();
  }

  changeAppColor(Color pickedColor) {
    LocalStorage().setInt(LocalStorage.selectedColorValue, pickedColor.value);
    primaryColor = pickedColor;
    update();
  }

  loadUserData() async {
    String userId = LocalStorage().getString(LocalStorage.userId);
    DocumentSnapshot snapshot = await UserService().getUser(userId);
    user = UserModel.fromJson(snapshot.data);
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
    if (selectedImage != null) {
      StorageReference reference =
          FirebaseStorage.instance.ref().child('Users/${user.id}');
      StorageUploadTask task = reference.putFile(File(selectedImage.path));
      task.onComplete.then((value) {
        reference.getDownloadURL().then((url) async {
          print(url);
          user.photo = url;
          _addRemainData(name, email, phone);
        });
      });
    } else {
      _addRemainData(name, email, phone);
    }
  }

  _addRemainData(String name, String email, String phone) async {
    user.name = name;
    user.email = email;
    user.phone = phone;
    await UserService().addUserToFireStore(user);
    loading.value = false;
    Get.back();
    update();
  }

  logOut() async {
    LocalStorage().clear();
    Get.find<CartController>().products.clear();
    Get.find<MainController>().user = null;
    await FirebaseAuth.instance.signOut();
    update();
    Get.offAll(LoginScreen());
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
