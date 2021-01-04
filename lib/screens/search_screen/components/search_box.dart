import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onSubmitted,
  }) : super(key: key);

  final Function(String value) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsetsDirectional.only(end: 20, start: 20, bottom: 10, top: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onSubmitted: (value) {
          if (value.isNotEmpty) onSubmitted(value);
        },
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          hintText: 'search'.tr,
          hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
