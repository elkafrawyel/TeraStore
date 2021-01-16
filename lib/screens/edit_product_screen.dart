import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/edit_product_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/CommonMethods.dart';

import 'custom_widgets/button/custom_button.dart';
import 'custom_widgets/custom_appbar.dart';
import 'custom_widgets/menus/categories_drop_down_menu.dart';
import 'custom_widgets/text/custom_outline_text_form_field.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel productModel;
  final controller = Get.find<EditProductController>();

  EditProductScreen({this.productModel}) {
    controller.product = productModel;
    _getInitialValues();
  }

  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _setDataToView();
    return Scaffold(
      appBar: CustomAppBar(
        text: 'edit'.tr,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<EditProductController>(
          init: EditProductController(),
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
    Get.find<EditProductController>().setProductImage(File(image.path));
  }

  imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Get.find<EditProductController>().setProductImage(File(image.path));
  }

  Widget _productImage() {
    return GestureDetector(
      onTap: () {
        _showPicker();
      },
      child: controller.productImage == null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                productModel.image,
                fit: BoxFit.contain,
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
                text: 'edit'.tr,
                colorBackground: LocalStorage().primaryColor(),
                colorText: Colors.white,
                onPressed: () {
                  _editProduct();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _editProduct() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        controller.product.name = nameController.text;
        controller.product.description = descController.text;
        controller.product.price = int.parse(priceController.text);
        controller.product.discountPrice =
            int.parse(discountPriceController.text);
        controller.editProduct();
      } catch (_) {
        CommonMethods().showMessage('edit'.tr, 'invalidPrice'.tr);
      }
    }
  }

  _getInitialValues() {
    // var homeController = Get.find<HomeController>();
    // if (productModel.categoryId != null) {
    //   for (CategoryModel element in homeController.categories) {
    //     if (element.id == productModel.categoryId) {
    //       homeController.setCategoryModel(element,
    //           subCategoryIdToSelect: productModel.subCategoryId);
    //     }
    //   }
    // }
  }

  void _setDataToView() {
    nameController.text = productModel.name;
    descController.text = productModel.description;
    priceController.text = productModel.price.toString();
    discountPriceController.text = productModel.discountPrice.toString();
  }
}
