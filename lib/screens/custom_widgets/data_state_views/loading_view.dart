import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tera/helper/Constant.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Lottie.asset(loadingImage),
      ),
    );
  }
}
