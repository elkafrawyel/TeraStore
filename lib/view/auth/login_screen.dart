import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/helper/validator.dart';
import 'package:flutter_app/view/auth/register_screen.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_social_button.dart';
import 'package:flutter_app/view/custom_widgets/directional_widget.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_text_form_field.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: _authController,
      builder: (controller) => DirectionalWidget(
        pageUi: Scaffold(
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
                        top: 10, left: 10, right: 10, bottom: 50),
                    child: Column(
                      children: [
                        Card(
                          color: Colors.white,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(RegisterScreen());
                                        },
                                        child: CustomText(
                                          text: 'signUp'.tr,
                                          fontSize: 18,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: 'signInToContinue'.tr,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  CustomTextFormField(
                                    text: 'email'.tr,
                                    controller: emailController,
                                    hintText: 'iamdavid@gmail.com',
                                    keyboardType: TextInputType.emailAddress,
                                    validatorText: 'emailIsEmpty'.tr,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFormField(
                                    text: 'password'.tr,
                                    controller: passwordController,
                                    hintText: '***********',
                                    obscureText: true,
                                    validatorText: 'passwordIsEmpty'.tr,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                    text: 'forgetPassword'.tr,
                                    fontSize: 14,
                                    alignment: AlignmentDirectional.topEnd,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: CustomButton(
                                      colorBackground: primaryColor,
                                      colorText: Colors.white,
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
                        CustomText(
                          text: 'or'.tr,
                          alignment: AlignmentDirectional.center,
                          fontSize: 16,
                        ),
                        SizedBox(
                          height: 10,
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
      ),
    );
  }
}
