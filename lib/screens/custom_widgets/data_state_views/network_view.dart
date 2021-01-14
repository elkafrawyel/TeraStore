import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';

class NetworkView extends StatelessWidget {
  final Function onPress;

  NetworkView({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(noNetworkImage,
              width: double.infinity,
              height: 400,
              options: LottieOptions(enableMergePaths: true)),
          SizedBox(
            height: 10,
          ),
          Text(
            'noNetwork'.tr,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            text: 'retry'.tr,
            colorText: Colors.white,
            colorBackground: LocalStorage().primaryColor(),
            onPressed: onPress,
          )
        ],
      ),
    );
  }
}
