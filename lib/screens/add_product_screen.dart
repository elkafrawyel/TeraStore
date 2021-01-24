import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/add_product_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/menus/categories_drop_down_menu.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

import 'custom_widgets/text/custom_outline_text_form_field.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatelessWidget {
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  final controller = Get.find<AddProductController>();
  final homeController = Get.find<HomeController>();

  AddProductScreen() {
    homeController.categoryModel = null;
    homeController.subCategoryModel = null;
    controller.productImages.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: 'addProduct'.tr,
      ),
      backgroundColor: Constants.backgroundColor,
      body: SingleChildScrollView(
        child: GetBuilder<AddProductController>(
          init: AddProductController(),
          builder: (controller) => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                    children: [
                      _buildImagesView(),
                      SizedBox(
                        height: 20,
                      ),
                      _productDetailsForm()
                    ],
                  ),
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
      ),
    );
  }

  void _showPicker() {
    if (controller.productImages.length == 5) {
      CommonMethods().showSnackBar('You can\'t add more than 5 images');
      return;
    }
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
    controller.setProductImage(File(image.path));
  }

  imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    controller.setProductImage(File(image.path));
  }

  _buildImagesView() {
    return Column(
      children: [
        _buildMainImage(),
        SizedBox(
          height: kDefaultPadding / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSingleImage(imageIndex: 1),
            _buildSingleImage(imageIndex: 2),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSingleImage(imageIndex: 3),
            _buildSingleImage(imageIndex: 4),
          ],
        )
      ],
    );
  }

  Widget _buildMainImage() {
    return controller.productImages.isEmpty
        ? GestureDetector(
            onTap: () {
              _showPicker();
            },
            child: Container(
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(Get.context).size.width / 2,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    color: Colors.grey.shade700,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  CustomText(
                    text: 'Main Image',
                    alignment: AlignmentDirectional.center,
                    fontSize: fontSizeBig_18,
                    color: Colors.grey.shade700,
                  )
                ],
              ),
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(controller.productImages[0].path),
                      fit: BoxFit.contain,
                      height: 200,
                      width: MediaQuery.of(Get.context).size.width / 2,
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                child: IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    controller.productImages.removeAt(0);
                    controller.update();
                  },
                ),
                end: 0,
                top: 0,
              )
            ],
          );
  }

  Widget _buildSingleImage({int imageIndex}) {
    return controller.productImages.length <= imageIndex
        ? GestureDetector(
            onTap: () {
              _showPicker();
            },
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 4),
              child: Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                ),
                width: MediaQuery.of(Get.context).size.width / 2.5,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.grey.shade700,
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    CustomText(
                      text: 'Image $imageIndex',
                      alignment: AlignmentDirectional.center,
                      fontSize: fontSizeBig_18,
                      color: Colors.grey.shade700,
                    )
                  ],
                ),
              ),
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kDefaultPadding / 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(controller.productImages[imageIndex].path),
                      fit: BoxFit.contain,
                      height: 150,
                      width: MediaQuery.of(Get.context).size.width / 3,
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                child: IconButton(
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    controller.productImages.removeAt(imageIndex);
                    controller.update();
                  },
                ),
                end: 0,
                top: 0,
              )
            ],
          );
  }

  Widget _productDetailsForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomOutlinedTextFormField(
              text: 'name'.tr,
              hintText: 'name'.tr,
              controller: nameController,
              validateEmptyText: 'nameIsEmpty'.tr,
              keyboardType: TextInputType.text,
              labelText: 'name'.tr,
            ),
            SizedBox(
              height: 20,
            ),
            CustomOutlinedTextFormField(
              text: 'description'.tr,
              hintText: 'description'.tr,
              controller: descController,
              maxLines: 4,
              validateEmptyText: 'emptyDesc'.tr,
              keyboardType: TextInputType.text,
              labelText: 'description'.tr,
            ),
            SizedBox(
              height: 20,
            ),
            CustomOutlinedTextFormField(
              text: 'quantity'.tr,
              hintText: 'quantity'.tr,
              controller: countController,
              validateEmptyText: 'emptyDesc'.tr,
              keyboardType: TextInputType.text,
              labelText: 'quantity'.tr,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(Get.context).size.width * 0.4,
                  child: CustomOutlinedTextFormField(
                    text: 'price'.tr,
                    suffixText: currency,
                    hintText: '0',
                    validateEmptyText: 'emptyPrice'.tr,
                    controller: priceController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    labelText: 'price'.tr,
                  ),
                ),
                Container(
                  width: MediaQuery.of(Get.context).size.width * 0.4,
                  child: CustomOutlinedTextFormField(
                    text: 'discountPrice'.tr,
                    hintText: '0',
                    validateEmptyText: 'emptyPrice'.tr,
                    suffixText: currency,
                    required: false,
                    controller: discountPriceController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    labelText: 'discountPrice'.tr,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CategoriesDropDownMenu(),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(Get.context).size.width * 0.6,
              child: CustomButton(
                text: 'addProduct'.tr,
                colorBackground: LocalStorage().primaryColor(),
                colorText: Colors.white,
                onPressed: () {
                  _addProduct();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addProduct() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      controller.addProduct(
        nameController.text,
        descController.text,
        priceController.text,
        discountPriceController.text.isEmpty
            ? '0'
            : discountPriceController.text,
        countController.text,
      );
    }
  }
}
