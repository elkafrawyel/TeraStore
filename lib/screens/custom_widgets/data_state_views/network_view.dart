import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tera/helper/Constant.dart';

class NetworkView extends StatelessWidget {
  final Function onPress;

  NetworkView({this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width / 2,
          //   child: CustomButton(
          //     text: 'retry'.tr,
          //     colorText: Colors.white,
          //     colorBackground: LocalStorage().primaryColor(),
          //     onPressed: onPress.call(),
          //   ),
          // )
        ],
      ),
    );
  }
}
