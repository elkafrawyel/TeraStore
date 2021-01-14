import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/screens/custom_widgets/data_state_views/network_view.dart';

class CheckInternet {
  // ignore: cancel_subscriptions
  static StreamSubscription<DataConnectionStatus> reader;
  static bool isDialogOn = false;

  static checkConnection() async {
    reader = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          if (isDialogOn) {
            Get.back();
            isDialogOn = false;
          }
          print('You are connected');
          break;

        case DataConnectionStatus.disconnected:
          print('You are disconnected');
          showDialog(
              context: Get.context,
              barrierDismissible: false,
              // barrierColor: Colors.grey.shade200,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: NetworkView(),
                );
              });
          isDialogOn = true;
          break;
      }
    });
  }
}
