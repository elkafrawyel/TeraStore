import 'package:flutter/material.dart';

class CustomAddToCartButton extends StatelessWidget {
  final Function onPressed;

  CustomAddToCartButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white.withOpacity(0.8),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.add_shopping_cart_rounded,
            color: Colors.grey,
            size: 30,
          ),
        ),
      ),
    );
  }
}
