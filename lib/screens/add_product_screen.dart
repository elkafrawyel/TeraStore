import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/controllers/add_product_controller.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/screens/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/screens/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/screens/custom_widgets/menus/categories_drop_down_menu.dart';
import 'package:flutter_app/screens/custom_widgets/text/custom_outline_text_form_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatelessWidget {
  //add product with notification uploading message like RZ

  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();
  AddProductController _addProductController;

  @override
  Widget build(BuildContext context) {
    _addProductController = Get.put(AddProductController());

    return Scaffold(
      appBar: CustomAppBar(
        text: 'addProduct'.tr,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddProductController>(
          init: _addProductController,
          builder: (controller) => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                    children: [
                      _productImage(),
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

  Widget _productImage() {
    return GestureDetector(
      onTap: () {
        _showPicker();
      },
      child: _addProductController.productImage == null
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
                File(_addProductController.productImage.path),
                fit: BoxFit.contain,
              ),
            ),
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
              hintText: 'emptyDescription'.tr,
              controller: descController,
              maxLines: 6,
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
              width: MediaQuery.of(Get.context).size.width * 0.6,
              child: CustomButton(
                text: 'addProduct'.tr,
                colorBackground: Get.find<MainController>().primaryColor,
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

      try {
        int price = int.parse(priceController.text);
        int discountPrice = int.parse(discountPriceController.text);
        _addProductController.addProduct(
            nameController.text, descController.text, price, discountPrice);
      } catch (_) {
        CommonMethods().showMessage('addProduct'.tr, 'invalidPrice'.tr);
      }
    }
  }
}
