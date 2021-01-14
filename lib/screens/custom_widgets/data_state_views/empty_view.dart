import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tera/helper/Constant.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final EmptyViews emptyViews;
  final Color textColor;

  EmptyView({this.message, this.emptyViews, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emptyImage(),
          Text(
            message == null ? 'empty'.tr : message,
            style: TextStyle(fontSize: 18, color: textColor),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _emptyImage() {
    switch (emptyViews) {
      case EmptyViews.Box:
        return Lottie.asset(emptyImageBox,
            width: 300, height: 300, repeat: false);
      case EmptyViews.Face:
        return Lottie.asset(emptyImageFace, repeat: false);
      case EmptyViews.Magnifier:
        return Lottie.asset(emptyImageMagnifier, repeat: true);
        break;
    }
    return Lottie.asset(emptyImageBox, width: 300, height: 300, repeat: false);
  }
}

enum EmptyViews {
  Box,
  Face,
  Magnifier,
}
