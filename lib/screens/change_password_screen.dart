import 'package:flutter/material.dart';
import 'package:flutter_app/a_storage/local_storage.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:get/get.dart';

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
      body: Form(
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
                controller: oldPasswordController,
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
                controller: oldPasswordController,
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
    );
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
  }
}
