import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'file:///F:/Apps/My%20Flutter%20Apps/E-commerce/lib/storage/local_storage.dart';

import '../text/custom_text.dart';
import 'package:get/get.dart';

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
          padding: EdgeInsets.only(top: 10,bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_shopping_cart_rounded,
                color: Get.find<MainController>().primaryColor,
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
