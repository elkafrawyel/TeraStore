import 'package:flutter/material.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_button.dart';
import 'package:get/get.dart';

class CommonMethods {
  // bool handleResponse(Response<dynamic> response) {
  //   switch (response.statusCode) {
  //     case 200:
  //     case 201:
  //     case 202:
  //       print('OK');
  //       return true;
  //
  //     case 400:
  //       print('Bad Request');
  //       return false;
  //
  //     case 401:
  //       print('Unauthorized');
  //       return false;
  //
  //     case 403:
  //       print('Forbidden Request');
  //       return false;
  //
  //     case 404:
  //       print('Page Not Found');
  //       return false;
  //
  //     case 405:
  //       print('Method Not Allowed');
  //       return false;
  //
  //     case 406:
  //     case 429:
  //       print('Not Acceptable');
  //       return false;
  //
  //     case 500:
  //       print('Internal Server Error');
  //       return false;
  //   }
  //
  //   return false;
  // }

  showMessage(String title, String body) {
    Get.snackbar(title, body,
        colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
  }

  hideKeyboard() {
    FocusScope.of(Get.context).unfocus();
  }

  Future<bool> customExitAlert({
    BuildContext context,
    Function action,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        scrollable: true,
        title: Text(
          'logOutMessage'.tr,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomButton(
              text: 'ok'.tr,
              colorText: primaryColor,
              onPressed: () {
                Get.back();
                action();
              },
            ),
            CustomButton(
              text: 'cancel'.tr,
              colorText: Colors.red,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
