import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'about'.tr,
      ),
      backgroundColor: LocalStorage().primaryColor(),
      body: Container(
        child: Center(
          child: Text(
            'Developer Information',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
