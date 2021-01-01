import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Lottie.asset(loadingImage),
      ),
    );
  }
}
