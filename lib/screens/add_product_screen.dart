import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/add_product_controller.dart';
import 'package:flutter_app/core/controllers/home_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/menus/categories_drop_down_menu.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatelessWidget {
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();

  AddProductScreen() {
    Get.find<HomeController>().categoryModel = null;
    Get.find<HomeController>().subCategoryModel = null;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());

    return Scaffold(
      appBar: CustomAppBar(
        text: 'addProduct'.tr,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddProductController>(
          builder: (controller) => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                    children: [
                      _productImage(controller),
                      SizedBox(
                        height: 20,
                      ),
                      _productDetailsForm(controller)
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
    Get.find<AddProductController>().setProductImage(File(image.path));
  }

  imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Get.find<AddProductController>().setProductImage(File(image.path));
  }

  Widget _productImage(AddProductController controller) {
    return GestureDetector(
      onTap: () {
        _showPicker();
      },
      child: controller.productImage == null
          ? Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              width: 200,
              height: 150,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[800],
              ),
            )
          :
          //Image
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(controller.productImage.path),
                fit: BoxFit.contain,
              ),
            ),
    );
  }

  Widget _productDetailsForm(AddProductController controller) {
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
              labelText: 'Description',
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
                    suffixText: '\$',
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
                    suffixText: '\$',
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
                  _addProduct(controller);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addProduct(AddProductController controller) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        int price = int.parse(priceController.text);
        int discountPrice = int.parse(discountPriceController.text);
        controller.addProduct(
            nameController.text, descController.text, price, discountPrice);
      } catch (_) {
        CommonMethods().showMessage('addProduct'.tr, 'invalidPrice'.tr);
      }
    }
  }
}
