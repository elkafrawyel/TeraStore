import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomOutLinedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color colorBackground;
  final Color colorText;
  final Color borderColor;

  CustomOutLinedButton(
      {this.text,
      this.onPressed,
      this.colorBackground,
      this.colorText,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: borderColor)),
      child: CustomButton(
        text: text,
        onPressed: () {
          onPressed();
        },
        colorBackground: colorBackground,
        colorText: colorText,
      ),
    );
  }
}
