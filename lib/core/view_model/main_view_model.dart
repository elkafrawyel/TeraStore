
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:flutter_app/view/auth/login_screen.dart';
import 'package:flutter_app/view/home/cart_screen.dart';
import 'package:flutter_app/view/home/explore_screen.dart';
import 'package:flutter_app/view/home/profile_screen.dart';
import 'package:get/get.dart';

class MainViewModel extends GetxController {
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> empty = ValueNotifier(false);

  int _navigatorSelectedIndex = 0;

  get navigatorSelectedIndex => _navigatorSelectedIndex;
  Widget _currentScreen = ExploreScreen();

  get currentScreen => _currentScreen;

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _user;

  UserModel get user => _user;

  loadUserData() async {
    String userId = _auth.currentUser?.uid;
    if (userId == null) return;
    if (_user != null && _user.id == userId) return;
    loading.value = true;
    UserService().getUser(userId).then((docs) {
      if (docs.length == 0) logOut();
      docs.forEach((element) {
        _user = UserModel.fromJson(element.data());
        loading.value = false;
        update();
        print(_user);
      });
    }).catchError((onError) {
      loading.value = false;
    });
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
