import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:flutter_app/view/home/cart_screen.dart';
import 'package:flutter_app/view/home/explore_screen.dart';
import 'package:flutter_app/view/home/profile_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MainController extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> empty = ValueNotifier(false);

  int _navigatorSelectedIndex = 0;

  get navigatorSelectedIndex => _navigatorSelectedIndex;
  Widget _currentScreen = ExploreScreen();

  get currentScreen => _currentScreen;

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _user;

  UserModel get user => _user;
  PickedFile selectedImage;

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
    update();
    Get.find<MainController>().setScreen(ProfileScreen());
  }

  logOut() async {
    await _auth.signOut();
    resetData();
    Get.offAll(LoginScreen());
  }

  void changeSelectedIndex(int selectedIndex) {
    _navigatorSelectedIndex = selectedIndex;

    switch (selectedIndex) {
      case 0:
        _currentScreen = ExploreScreen();
        break;

      case 1:
        _currentScreen = CartScreen();
        break;

      case 2:
        _currentScreen = ProfileScreen();
        break;
    }
    update();
  }

  setScreen(Widget screen) {
    _currentScreen = screen;
    update();
  }

  resetData() {
    _currentScreen = ExploreScreen();
    _navigatorSelectedIndex = 0;
  }
}
