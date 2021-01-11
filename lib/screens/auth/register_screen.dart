import 'package:flutter/material.dart';
import 'package:flutter_app/a_storage/local_storage.dart';
import 'package:flutter_app/controllers/auth_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/helper/validator.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
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
                  padding: const EdgeInsets.only(
                      top: kDefaultPadding * 2,
                      left: kDefaultPadding / 2,
                      right: kDefaultPadding / 2,
                      bottom: kDefaultPadding * 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                  CustomText(
                                    text: 'signUp'.tr,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: kDefaultPadding * 2,
                              ),
                              CustomOutlinedTextFormField(
                                text: 'name'.tr,
                                controller: nameController,
                                hintText: 'name'.tr,
                                labelText: 'name'.tr,
                                keyboardType: TextInputType.text,
                                validateEmptyText: 'nameIsEmpty'.tr,
                                labelColor: Colors.white,
                                hintColor: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
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
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomOutlinedTextFormField(
                                text: 'phone'.tr,
                                hintText: 'phoneHint'.tr,
                                controller: phoneController,
                                validateEmptyText: 'phoneIsEmpty'.tr,
                                keyboardType: TextInputType.phone,
                                labelText: 'phone'.tr,
                                labelColor: Colors.white,
                                hintColor: Colors.white,
                              ),
                              SizedBox(
                                height: 20,
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
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: CustomButton(
                                  colorBackground: LocalStorage()
                                      .primaryColor()
                                      .withOpacity(0.7),
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
                                            phoneController.text,
                                            passwordController.text);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
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
