import 'package:flutter/material.dart';
import '../text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color colorBackground;
  final Color colorText;

  CustomButton(
      {this.text, this.onPressed, this.colorBackground, this.colorText});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onPressed,
        color: colorBackground,
        child: CustomText(
          text: text,
          fontSize: 16,
          color: colorText,
          alignment: AlignmentDirectional.center,
        ));
  }
}
