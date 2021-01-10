import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/storage/local_storage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget> actions;
  final double elevation;

  CustomAppBar({this.text = '', this.actions, this.elevation = 0});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: elevation,
      iconTheme: IconThemeData(
        color: Constants.appBarTextColor,
      ),
      backgroundColor: LocalStorage().primaryColor(),
      title: Text(
        text,
        style: TextStyle(color: Constants.appBarTextColor, fontSize: 16),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Constants.appBarHeight);
}
