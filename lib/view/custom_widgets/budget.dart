import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';

class BudgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: Badge(
          badgeColor: Colors.deepPurple,
          badgeContent: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('3', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              cartImage,
              fit: BoxFit.contain,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
