import 'dart:io';

import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_repositories/user_repo.dart';
import 'package:tera/helper/CommonMethods.dart';

class NetworkMethods {
  handleResponse({
    Future<chopper.Response<dynamic>> call,
    Function(chopper.Response response) whenSuccess,
  }) async {
    try {
      chopper.Response response = await call;
      switch (response.statusCode) {
        case 200:
          print('OK');
          whenSuccess(response);
          return ApiState.success;

        case 400:
          print('Bad Request');
          CommonMethods()
              .showSnackBar('serverNotFound'.tr, iconData: Icons.error);
          return ApiState.error;

        case 401:
          _unauthorized();
          return ApiState.unauthorized;

        case 403:
          print('Forbidden Request');
          CommonMethods()
              .showSnackBar('serverNotFound'.tr, iconData: Icons.error);
          return ApiState.error;

        case 404:
          print('Page Not Found');
          CommonMethods()
              .showSnackBar('serverNotFound'.tr, iconData: Icons.error);
          return ApiState.error;

        case 405:
          print('Method Not Allowed');
          CommonMethods()
              .showSnackBar('serverNotFound'.tr, iconData: Icons.error);
          return ApiState.error;

        case 406:
        case 429:
          print('Not Acceptable');
          CommonMethods()
              .showSnackBar('serverNotFound'.tr, iconData: Icons.error);
          return ApiState.error;

        case 500:
          print('Internal Server Error');
          CommonMethods()
              .showSnackBar('serverNotFound'.tr, iconData: Icons.error);
          return ApiState.error;
      }
    } on SocketException {
      CommonMethods()
          .showSnackBar('noInternetDialogTitle'.tr, iconData: Icons.wifi_off);
    }
  }

  void _unauthorized() {
    print('Unauthorized');
    UserRepo().localLogOut();
    CommonMethods().showMessage('message'.tr, 'Unauthorized Login Again');
  }
}

enum ApiState { success, error, unauthorized }
