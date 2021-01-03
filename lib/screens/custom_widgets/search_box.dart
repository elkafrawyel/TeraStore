import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.white,fontSize: 18),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(Icons.search,color: Colors.white,size: 30,),
          hintText: 'search'.tr,
          hintStyle: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }
}
