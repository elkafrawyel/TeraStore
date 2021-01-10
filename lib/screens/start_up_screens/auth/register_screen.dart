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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
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
                ),
              ),
              child: SingleChildScrollView(
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
                                labelColor: Colors.black,
                                hintColor: Colors.black,
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
                                labelColor: Colors.black,
                                hintColor: Colors.black,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomOutlinedTextFormField(
                                text: 'phone'.tr,
                                hintText: 'phoneHint'.tr,
                                controller: phoneController,
                                validateEmptyText: 'Phone Empty',
                                keyboardType: TextInputType.phone,
                                labelText: 'Phone',
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
                                labelColor: Colors.black,
                                hintColor: Colors.black,
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
