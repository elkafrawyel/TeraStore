import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';

import 'package:get/get.dart';

import '../profile/profile_screen.dart';

class NotificationsScreen extends StatelessWidget {
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
                      Get.back();
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
