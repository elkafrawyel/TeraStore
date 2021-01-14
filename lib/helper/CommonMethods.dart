import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class CommonMethods {
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
          fontSize: 18,
        ),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: LocalStorage().primaryColor(),
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

  Future<bool> customAlert(
      {String title, String message, Function action}) async {
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
