import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/helper/validator.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_social_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen(){
    Get.put(AuthController());
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Constants.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: kDefaultPadding / 2,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'welcome'.tr,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(RegisterScreen());
                                      },
                                      child: CustomText(
                                        text: 'signUp'.tr,
                                        fontSize: 16,
                                        color: Get.find<MainController>()
                                            .primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: 'signInToContinue'.tr,
                                  fontSize: 16,
                                  color: Colors.grey.shade800,
                                ),
                                SizedBox(
                                  height: kDefaultPadding,
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
                                  height: kDefaultPadding,
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
                                  height: kDefaultPadding,
                                ),
                                CustomText(
                                  text: 'forgetPassword'.tr,
                                  fontSize: 16,
                                  alignment: AlignmentDirectional.topEnd,
                                ),
                                SizedBox(
                                  height: kDefaultPadding * 2,
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: CustomButton(
                                    colorBackground:
                                        LocalStorage().primaryColor(),
                                    colorText: Colors.white,
                                    fontSize: 20,
                                    text: 'signIn'.tr,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        FocusScope.of(context).unfocus();

                                        if (Validator().validateEmail(
                                            emailController.text)) {
                                          _formKey.currentState.save();
                                          controller.signInEmail(
                                              emailController.text,
                                              passwordController.text);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: kDefaultPadding/2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPadding/2,
                      ),
                      CustomText(
                        text: 'or'.tr,
                        alignment: AlignmentDirectional.center,
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: kDefaultPadding/2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomSocialButton(
                          imageAsset: facebookImage,
                          text: 'signInFaceBook'.tr,
                          onPressed: () {
                            controller.signInFacebook();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: CustomSocialButton(
                          imageAsset: googleImage,
                          text: 'signInGoogle'.tr,
                          onPressed: () {
                            controller.signInGoogle();
                          },
                        ),
                      )
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
