import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:get/get.dart';

class BudgetCartIconView extends StatelessWidget {
  final Function press;

  BudgetCartIconView({this.press});

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        press();
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 20),
        child: Container(
          width: 50,
          height: 50,
          child: Center(
            child: Badge(
              badgeColor: Colors.black,
              animationType: BadgeAnimationType.slide,
              badgeContent: Obx(
                () => Text(
                  controller.cartCount.value.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
