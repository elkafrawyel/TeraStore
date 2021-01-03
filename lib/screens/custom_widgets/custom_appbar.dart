import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget> actions;

  CustomAppBar({this.text = '', this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Constants.appBarTextColor,
      ),
      backgroundColor: Constants.appBarBackgroundColor,
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
