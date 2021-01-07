import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/helper/validator.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: kDefaultPadding * 2,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'signUp'.tr,
                                  fontSize: 25,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomOutlinedTextFormField(
                                  text: 'name'.tr,
                                  controller: nameController,
                                  hintText: 'name'.tr,
                                  labelText: 'name'.tr,
                                  keyboardType: TextInputType.text,
                                  validateEmptyText: 'nameIsEmpty'.tr,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CustomOutlinedTextFormField(
                                  text: 'email'.tr,
                                  controller: emailController,
                                  hintText: 'someone@something.com',
                                  labelText: 'email'.tr,
                                  validateEmptyText: 'emailIsEmpty'.tr,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CustomOutlinedTextFormField(
                                  text: 'password'.tr,
                                  controller: passwordController,
                                  hintText: '***********',
                                  isPassword: true,
                                  maxLines: 1,
                                  labelText: 'password'.tr,
                                  validateEmptyText: 'passwordIsEmpty'.tr,
                                  keyboardType: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: CustomButton(
                                    colorBackground:
                                        LocalStorage().primaryColor(),
                                    colorText: Colors.white,
                                    text: 'signUp'.tr,
                                    fontSize: 20,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        FocusScope.of(context).unfocus();

                                        if (Validator().validateEmail(
                                            emailController.text)) {
                                          _formKey.currentState.save();
                                          controller.createAccount(
                                              nameController.text,
                                              emailController.text,
                                              passwordController.text);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
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
            ],
          ),
        ),
      ),
    );
  }
}
