import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
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

  LoginScreen() {
    Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.white.withAlpha(150), BlendMode.dstATop),
                image: AssetImage(
                  'src/images/login_back.jpg',
                ),
              )),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: kDefaultPadding / 2,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: kDefaultPadding, top: kDefaultPadding),
                          child: CustomText(
                            text: 'welcome'.tr,
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomText(
                          text: 'signInToContinue'.tr,
                          fontSize: 18,
                          alignment: AlignmentDirectional.center,
                          color: Colors.black,
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
                          labelColor: Colors.black,
                          hintColor: Colors.black,
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
                          labelColor: Colors.black,
                          hintColor: Colors.black,
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
                          height: kDefaultPadding,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: CustomButton(
                            colorBackground:
                                LocalStorage().primaryColor().withOpacity(0.6),
                            colorText: Colors.white,
                            fontSize: 20,
                            text: 'signIn'.tr,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                FocusScope.of(context).unfocus();

                                if (Validator()
                                    .validateEmail(emailController.text)) {
                                  _formKey.currentState.save();
                                  controller.signInEmail(emailController.text,
                                      passwordController.text);
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: CustomButton(
                            colorBackground:
                                LocalStorage().primaryColor().withOpacity(0.7),
                            colorText: Colors.white,
                            fontSize: 20,
                            text: 'signUp'.tr,
                            onPressed: () {
                              Get.to(RegisterScreen());
                            },
                          ),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        CustomText(
                          text: 'or'.tr,
                          alignment: AlignmentDirectional.center,
                          fontSize: 18,
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
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
    );
  }
}
