import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/auth_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/helper/validator.dart';
import 'package:flutter_app/screens/auth/login_screen.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/directional_widget.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text_form_field.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(),
      builder: (controller) => DirectionalWidget(
        pageUi: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Get.off(LoginScreen());
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
                        top: 20, left: 10, right: 10, bottom: 50),
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
                                  CustomTextFormField(
                                    text: 'name'.tr,
                                    controller: nameController,
                                    hintText: 'Jane Alex',
                                    keyboardType: TextInputType.text,
                                    validatorText: 'nameIsEmpty'.tr,
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
                                    height: 30,
                                  ),
                                  CustomTextFormField(
                                    text: 'password'.tr,
                                    controller: passwordController,
                                    hintText: '***********',
                                    obscureText: true,
                                    validatorText: 'passwordIsEmpty'.tr,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: CustomButton(
                                      colorBackground: primaryColor,
                                      colorText: Colors.white,
                                      text: 'signUp'.tr,
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
      ),
    );
  }
}
