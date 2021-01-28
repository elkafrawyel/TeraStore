import 'dart:ui' as ui show window;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/helper/CommonMethods.dart';

import 'components/drawer_menu.dart';
import 'components/home.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  HomeScreen() {
    print('Date' + DateTime.now().millisecondsSinceEpoch.toString());
    print('Is AR ' + ZoomDrawer.isRTL().toString());

    ui.window.locales.first = Get.locale;

    Get.find<MainController>().loadUserData();
    Get.find<CartController>().getCartItems(showLoading: true);
    homeController.getSliderProducts();
    homeController.filterProducts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: GetBuilder<MainController>(
            builder: (controller) => GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // Note: Sensitivity is integer used when you don't want to mess up vertical drag
                    if (details.delta.dx > 6) {
                      print('Right Swipe');
                      if (LocalStorage().isArabicLanguage()) {
                        homeController.drawerController.close();
                      } else {
                        homeController.drawerController.open();
                      }
                    } else if (details.delta.dx < -6) {
                      print('Left Swipe');
                      if (LocalStorage().isArabicLanguage()) {
                        homeController.drawerController.open();
                      } else {
                        homeController.drawerController.close();
                      }
                    }
                  },
                  child: ZoomDrawer(
                    controller: homeController.drawerController,
                    menuScreen: DrawerMenu(),
                    mainScreen: Home(),
                    borderRadius: 30,
                    showShadow: true,
                    angle: -8,
                    slideWidth: ZoomDrawer.isRTL() ? 200 : 275,
                    backgroundColor: Colors.grey[300],
                    openCurve: Curves.easeInOutQuad,
                    closeCurve: Curves.easeOutBack,
                  ),
                )),
        onWillPop: _willPopCallback);
  }

  Future<bool> _willPopCallback() async {
    CommonMethods().customAlert(
        title: 'close'.tr,
        message: 'closeMessage'.tr,
        action: () {
          SystemNavigator.pop(animated: true);
        });
    return Future.value(true);
  }
}
