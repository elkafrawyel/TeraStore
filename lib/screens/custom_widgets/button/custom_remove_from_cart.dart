import 'package:flutter/material.dart';

class CustomRemoveFromCartButton extends StatelessWidget {
  final Function onPressed;

  CustomRemoveFromCartButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.green,
            size: 30,
          ),
        ),
      ),
    );
  }
}
