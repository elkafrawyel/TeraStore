import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';

class DefaultLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          CustomText(
            text: 'pleaseWait'.tr,
          )
        ],
      ),
    );
  }
}
