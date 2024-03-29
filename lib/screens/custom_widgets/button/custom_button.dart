import 'package:flutter/material.dart';

import '../text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color colorBackground;
  final Color colorText;
  final double fontSize;

  CustomButton(
      {this.text,
      this.onPressed,
      this.colorBackground,
      this.colorText,
      this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: colorBackground,
        child: CustomText(
          text: text,
          fontSize: fontSize,
          color: colorText,
          alignment: AlignmentDirectional.center,
        ));
  }
}
