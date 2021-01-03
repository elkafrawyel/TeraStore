import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget> actions;

  CustomAppBar({this.text = '', this.actions});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Constants.appBarTextColor,
        ),
        backgroundColor: controller.primaryColor,
        title: Text(
          text,
          style: TextStyle(color: Constants.appBarTextColor, fontSize: 16),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.appBarHeight);
}
