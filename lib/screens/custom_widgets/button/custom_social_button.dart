import 'package:flutter/material.dart';
import 'package:tera/helper/Constant.dart';

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
        color: Colors.white38,
        border: Border.all(width: 0.4, color: Colors.grey),
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
                width: 10,
              ),
              Image.asset(
                imageAsset,
                width: 30,
                height: 30,
              ),
              SizedBox(
                width: kDefaultPadding / 2,
              ),
              Expanded(
                child: CustomText(
                  text: text,
                  fontSize: 16,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
