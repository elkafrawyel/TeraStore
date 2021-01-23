import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/auth_controller.dart';
import 'package:tera/helper/CheckInternet.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/button/custom_social_button.dart';
import 'package:tera/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final controller = Get.put(AuthController());
  final CheckInternet check = CheckInternet();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage(
                      'src/images/login_back.jpg',
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: kDefaultPadding / 2,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: kDefaultPadding, top: kDefaultPadding),
                              child: CustomText(
                                text: 'welcome'.tr,
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: kDefaultPadding,
                                  top: kDefaultPadding / 2),
                              child: CustomText(
                                text: 'signInToContinue'.tr,
                                fontSize: 18,
                                alignment: AlignmentDirectional.centerStart,
                                color: Colors.white,
                              ),
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
                              labelColor: Colors.white,
                              hintColor: Colors.white,
                              textColor: Colors.white,
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
                              labelColor: Colors.white,
                              hintColor: Colors.white,
                              textColor: Colors.white,
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomText(
                              text: 'forgetPassword'.tr,
                              fontSize: 16,
                              alignment: AlignmentDirectional.topEnd,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: CustomButton(
                                colorBackground: LocalStorage()
                                    .primaryColor()
                                    .withOpacity(0.6),
                                colorText: Colors.white,
                                fontSize: 20,
                                text: 'signIn'.tr,
                                onPressed: () {
                                  _login();
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
                                colorBackground: LocalStorage()
                                    .primaryColor()
                                    .withOpacity(0.7),
                                colorText: Colors.white,
                                fontSize: 20,
                                text: 'signUp'.tr,
                                onPressed: () {
                                  Get.to(RegisterScreen());
                                },
                              ),
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomText(
                                text: 'or'.tr,
                                alignment: AlignmentDirectional.center,
                                fontSize: 18,
                                color: Colors.white),
                            SizedBox(
                              height: kDefaultPadding,
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
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.9,
                            //   child: CustomSocialButton(
                            //     imageAsset: twitterImage,
                            //     text: 'signInTwitter'.tr,
                            //     onPressed: () {
                            //       controller.signInGoogle();
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
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

  void _login() {
    if (_formKey.currentState.validate()) {
      FocusScope.of(Get.context).unfocus();

      if (!GetUtils.isEmail(emailController.text)) {
        CommonMethods().showSnackBar('enterValidEmail'.tr);
        return;
      }

      _formKey.currentState.save();
      controller.login(emailController.text, passwordController.text);
    }
  }
}
