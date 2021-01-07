import 'package:flutter/material.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:get/get.dart';
class CardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'cards'.tr,
      ),
    );
  }
}
