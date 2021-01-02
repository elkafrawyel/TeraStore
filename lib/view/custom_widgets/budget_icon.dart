import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/cart_controller.dart';
import 'package:get/get.dart';

class BudgetIconView extends StatelessWidget {
  BudgetIconView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
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
            padding: const EdgeInsets.all(20.0),
            child: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
