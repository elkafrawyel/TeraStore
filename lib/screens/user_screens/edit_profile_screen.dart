import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_text.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../profile/profile_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.find<MainController>().selectedImage = null;
    nameController.text = Get.find<MainController>().user.name;
    emailController.text = Get.find<MainController>().user.email;
    phoneController.text = Get.find<MainController>().user.phone;
    locationController.text = Get.find<MainController>().user.location;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        body: GetBuilder<MainController>(
          builder: (controller) => SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 20, top: 20),
                              child: Icon(Icons.arrow_back),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 20, top: 20),
                            child: CustomText(
                              fontSize: 18,
                              text: 'editProfile'.tr,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: controller.selectedImage == null
                                  ? NetworkImage(controller.user.photo)
                                  : FileImage(
                                      File(controller.selectedImage.path)),
                              radius: 50,
                            ),
                          ),
                          Positioned.fill(
                              child: Align(
                            alignment: AlignmentDirectional.bottomStart,
                            child: GestureDetector(
                              onTap: () {
                                _showPicker();
                              },
                              child: Icon(
                                Icons.photo_camera,
                                size: 30,
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              CustomOutlinedTextFormField(
                                text: 'Name',
                                hintText: 'your name',
                                controller: nameController,
                                validateEmptyText: 'Name Empty',
                                keyboardType: TextInputType.text,
                                labelText: 'Name',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomOutlinedTextFormField(
                                text: 'Email',
                                hintText: 'your email',
                                controller: emailController,
                                validateEmptyText: 'Email Empty',
                                keyboardType: TextInputType.text,
                                labelText: 'Email',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomOutlinedTextFormField(
                                text: 'Phone',
                                hintText: 'your phone',
                                controller: phoneController,
                                validateEmptyText: 'Phone Empty',
                                keyboardType: TextInputType.phone,
                                labelText: 'Phone',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomOutlinedTextFormField(
                                text: 'Address',
                                hintText: 'your address',
                                controller: locationController,
                                validateEmptyText: 'Address Empty',
                                keyboardType: TextInputType.phone,
                                labelText: 'Address',
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(Get.context).size.width * 0.6,
                                child: CustomButton(
                                  text: 'Save',
                                  colorBackground: primaryColor,
                                  colorText: Colors.white,
                                  onPressed: () {
                                    _save();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.loading.value,
                  child: Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _showPicker() {
    showModalBottomSheet(
        context: Get.context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('gallery'.tr),
                      onTap: () {
                        imgFromGallery();
                        Get.back();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('camera'.tr),
                    onTap: () {
                      imgFromCamera();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
    Get.find<MainController>().setUserImage(image);
  }

  imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Get.find<MainController>().setUserImage(image);
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Get.find<MainController>().editProfile(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          location: locationController.text);
    }
  }
}
