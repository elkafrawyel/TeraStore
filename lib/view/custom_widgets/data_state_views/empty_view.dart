import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Constants.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(emptyImage),
          Text(
            'empty'.tr,
            style: TextStyle(fontSize: 18,color: Colors.grey.shade500),
          )
        ],
      ),
    );
  }
}
