import 'package:flutter/material.dart';

import '../text/custom_text.dart';

class CustomSocialButton extends StatelessWidget {
  final String imageAsset, text;
  final Function onPressed;

  CustomSocialButton({this.imageAsset, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: FlatButton(
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Image.asset(
                imageAsset,
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: 50,
              ),
              CustomText(
                text: text,
              )
            ],
          )),
    );
  }
}
