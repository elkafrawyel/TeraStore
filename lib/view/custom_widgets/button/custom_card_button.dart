import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';

import '../text/custom_text.dart';
import 'package:get/get.dart';

class CustomCardButton extends StatelessWidget {
  final Function onPressed;

  CustomCardButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: FlatButton(
          padding: EdgeInsets.only(top: 10,bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag,
                color: primaryColor,
                size: 40,
              ),
              SizedBox(
                width: 5,
              ),
              CustomText(
                fontSize: 18,
                alignment: AlignmentDirectional.center,
                text: 'addToCart'.tr,
              )
            ],
          )),
    );
  }
}
