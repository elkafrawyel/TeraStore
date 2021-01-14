import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';

import '../text/custom_text.dart';

class CustomCartButton extends StatelessWidget {
  final Function onPressed;

  CustomCartButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
      ),
      child: FlatButton(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_shopping_cart_rounded,
                color: LocalStorage().primaryColor(),
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
