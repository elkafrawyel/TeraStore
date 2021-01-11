import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/cart_controller.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';

class BudgetTextView extends StatelessWidget {
  final int number;

  BudgetTextView({this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 50,
      child: Center(
        child: Badge(
          badgeColor: Colors.deepPurple,
          animationType: BadgeAnimationType.slide,
          badgeContent: GetBuilder<CartController>(
            builder: (controller) => Text(
              controller.cartCount.toString(),
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
            child: CustomText(
              text: 'cart'.tr,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
