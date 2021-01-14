import 'package:chopper/chopper.dart' as chopper;
import 'package:get/get.dart';
import 'package:tera/helper/CommonMethods.dart';

class NetworkMethods {
  ApiState handleResponse(chopper.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        print('OK');
        return ApiState.success;

      case 400:
        print('Bad Request');
        return ApiState.error;

      case 401:
        print('Unauthorized');
        return ApiState.unauthorized;

      case 403:
        print('Forbidden Request');
        return ApiState.error;

      case 404:
        print('Page Not Found');
        return ApiState.error;

      case 405:
        print('Method Not Allowed');
        CommonMethods().showMessage('error'.tr, 'Method Not Allowed');
        return ApiState.error;

      case 406:
      case 429:
        print('Not Acceptable');
        CommonMethods().showMessage('error'.tr, 'Not Acceptable');
        return ApiState.error;

      case 500:
        print('Internal Server Error');
        CommonMethods().showMessage('error'.tr, 'Internal Server Error');
        return ApiState.error;
    }
    return ApiState.error;
  }
}

enum ApiState { success, error, unauthorized }
