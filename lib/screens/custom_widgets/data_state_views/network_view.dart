import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../../../storage/local_storage.dart';

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
