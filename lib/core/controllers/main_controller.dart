import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/screens/auth/login_screen.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MainController extends GetxController {
  Color primaryColor = LocalStorage().primaryColor();

  changeAppColor(Color pickedColor) {
    LocalStorage().setInt(LocalStorage.selectedColorValue, pickedColor.value);
    primaryColor = pickedColor;
    update();
  }

  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> empty = ValueNotifier(false);

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _user;

  UserModel get user => _user;
  PickedFile selectedImage;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  loadUserData() async {
    String userId = _auth.currentUser?.uid;
    if (userId == null) return;
    if (_user != null && _user.id == userId) return;
    loading.value = true;
    UserService().getUser(userId).then((doc) {
      _user = UserModel.fromJson(doc.data());
      loading.value = false;
      update();
      print(_user);
    }).catchError((onError) {
      loading.value = false;
    });
  }

  setUserImage(PickedFile image) {
    selectedImage = image;
    update();
  }

  editProfile(
      {String name, String email, String phone, String location}) async {
    loading.value = true;
    update();
    if (selectedImage != null) {
      Reference reference =
          FirebaseStorage.instance.ref().child('Users/${user.id}');
      reference.putFile(File(selectedImage.path)).then((value) {
        reference.getDownloadURL().then((url) async {
          print(url);
          user.photo = url;
          _addRemainData(name, email, phone, location);
        });
      });
    } else {
      _addRemainData(name, email, phone, location);
    }
  }

  _addRemainData(
      String name, String email, String phone, String location) async {
    user.name = name;
    user.email = email;
    user.phone = phone;
    user.location = location;
    await UserService().addUserToFireStore(user);
    loading.value = false;
    Get.back();
    update();
  }

  logOut() async {
    await _auth.signOut();
    Get.find<CartController>().products.clear();
    update();
    Get.offAll(LoginScreen());
  }
}
