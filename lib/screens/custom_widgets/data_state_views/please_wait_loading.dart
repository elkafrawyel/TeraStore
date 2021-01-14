import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class PleaseWaitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          CustomText(
            color: Colors.white,
            alignment: AlignmentDirectional.center,
            text: 'pleaseWait'.tr,
          )
        ],
      ),
    );
  }
}
