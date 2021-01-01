import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/view/home/profile_screen.dart';
import 'package:get/get.dart';

class MyProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.find<MainViewModel>().setScreen(ProfileScreen());
                    },
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 20, top: 20),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
