import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/controllers/cart_controller.dart';
import 'package:tera/helper/Constant.dart';

class BudgetCartIconView extends StatelessWidget {
  final Function press;

  BudgetCartIconView({this.press});

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
              badgeContent: GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) => Text(
                  controller.cartCount.toString(),
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
