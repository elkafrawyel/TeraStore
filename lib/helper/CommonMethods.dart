import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

class CommonMethods {
  showSnackBar(String message, {IconData iconData = Icons.info}) {
    Get.showSnackbar(GetBar(
      backgroundColor: LocalStorage().primaryColor(),
      messageText: CustomText(
        text: message,
        color: Colors.white,
        fontSize: fontSizeSmall_16,
      ),
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 30,
      ),
      duration: Duration(seconds: 3),
    ));
  }

  showMessage(String title, String body) {
    Get.snackbar(title, body,
        messageText: CustomText(
          text: body,
          fontSize: fontSizeSmall_16 - 2,
        ),
        titleText: CustomText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: fontSizeSmall_16,
        ),
        snackStyle: SnackStyle.FLOATING,
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
            fontSize: fontSizeSmall_16 - 2,
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
              fontSize: fontSizeSmall_16 - 2,
            ),
          ],
        ),
        content: CustomText(
          text: 'logOutMessage'.tr,
          fontSize: fontSizeSmall_16 - 2,
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
            fontSize: fontSizeSmall_16 - 2,
            onPressed: () {
              Get.back();
              action();
            },
          ),
          CustomButton(
            text: 'cancel'.tr,
            fontSize: fontSizeSmall_16 - 2,
            onPressed: () {
              Get.back();
            },
          ),
        ],
        title: CustomText(
          text: title,
          fontSize: fontSizeSmall_16,
        ),
        content: CustomText(
          text: message,
          fontSize: fontSizeSmall_16 - 2,
          maxLines: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
