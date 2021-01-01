import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class ErrorView extends StatelessWidget {
  final bool show;

  ErrorView({this.show});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: show,
        child: ListView(
          children: [
            Center(child: Lottie.asset(errorImage)),
            Center(
              child: Text(
                'error'.tr,
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
