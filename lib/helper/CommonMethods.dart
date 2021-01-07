import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/storage/local_storage.dart';
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
        messageText: CustomText(
          text: body,
          color: Colors.black,
          fontSize: 16,
        ),
        titleText: CustomText(
          text: title,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        snackStyle: SnackStyle.FLOATING,
        // backgroundColor: Colors.white,
        // colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
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
        backgroundColor: Colors.white,
        actions: [
          CustomButton(
            text: 'ok'.tr,
            onPressed: () {
              Get.back();
              action();
            },
          ),
          CustomButton(
            text: 'cancel'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        ],
        title: Row(
          children: [
            Image.asset(
              logo,
              width: 50,
              height: 50,
            ),
            CustomText(
              text: 'logOut'.tr,
              fontSize: 18,
            ),
          ],
        ),
        content: CustomText(
          text: 'logOutMessage'.tr,
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Future<bool> customAlert({String title,String message, Function action}) async {
    return showDialog(
      context: Get.context,
      builder: (ctx) => AlertDialog(
        scrollable: true,
        backgroundColor: Colors.white,
        actions: [
          CustomButton(
            text: 'ok'.tr,
            onPressed: () {
              Get.back();
              action();

            },
          ),
          CustomButton(
            text: 'cancel'.tr,
            onPressed: () {
              Get.back();
            },
          ),
        ],
        title: CustomText(
          text: title,
          fontSize: 20,
        ),
        content: CustomText(
          text: message,
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
