import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
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
          color: Colors.white,
          fontSize: 16,
        ),
        titleText: CustomText(
          text: title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: primaryColor,
        colorText: Colors.white,
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
        backgroundColor: primaryColor.shade500,
        actions: [
          CustomButton(
            text: 'ok'.tr,
            colorText: Colors.white,
            onPressed: () {
              Get.back();
              action();
            },
          ),
          CustomButton(
            text: 'cancel'.tr,
            colorText: Colors.white,
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
              fontSize: 20,
              color: Colors.white,
            ),
          ],
        ),
        content: CustomText(
          text: 'logOutMessage'.tr,
          color: Colors.white,
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Future<bool> customCloseAlert({
    BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        scrollable: true,
        backgroundColor: primaryColor.shade500,
        actions: [
          CustomButton(
            text: 'ok'.tr,
            colorText: Colors.white,
            onPressed: () {
              Get.back();
              SystemNavigator.pop(animated: true);
            },
          ),
          CustomButton(
            text: 'cancel'.tr,
            colorText: Colors.white,
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
              text: 'close'.tr,
              fontSize: 20,
              color: Colors.white,
            ),
          ],
        ),
        content: CustomText(
          text: 'closeMessage'.tr,
          color: Colors.white,
          fontSize: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
