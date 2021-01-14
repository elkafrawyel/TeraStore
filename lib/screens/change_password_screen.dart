import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/requests/change_password_request.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/text/custom_outline_text_form_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'changePassword'.tr,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CustomOutlinedTextFormField(
                    text: 'oldPassword'.tr,
                    maxLines: 1,
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    validateEmptyText: 'oldPasswordEmpty'.tr,
                    controller: oldPasswordController,
                    hintText: 'oldPassword'.tr,
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomOutlinedTextFormField(
                    text: 'newPassword'.tr,
                    maxLines: 1,
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    validateEmptyText: 'newPasswordEmpty'.tr,
                    controller: newPasswordController,
                    hintText: 'newPassword'.tr,
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomOutlinedTextFormField(
                    text: 'confirmNewPassword'.tr,
                    maxLines: 1,
                    isPassword: true,
                    keyboardType: TextInputType.text,
                    validateEmptyText: 'confirmNewPasswordEmpty'.tr,
                    controller: confirmNewPasswordController,
                    hintText: 'confirmNewPassword'.tr,
                  ),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: CustomButton(
                      text: 'save'.tr,
                      fontSize: 18,
                      colorBackground: LocalStorage().primaryColor(),
                      colorText: Colors.white,
                      onPressed: () {
                        _save();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          GetBuilder<MainController>(
            builder: (controller) => Positioned(
              top: 0.0,
              bottom: 0.0,
              right: 0.0,
              left: 0.0,
              child: Visibility(
                visible: controller.loading.value,
                child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Get.find<MainController>().changePassword(
        ChangePasswordRequest(
          oldPassword: oldPasswordController.text,
          password: newPasswordController.text,
          confirmPassword: confirmNewPasswordController.text,
        ),
      );
    }
  }
}
