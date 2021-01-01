import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/view_model/add_product_view_model.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/view/custom_widgets/button/custom_button.dart';
import 'package:flutter_app/view/custom_widgets/custom_appbar.dart';
import 'package:flutter_app/view/custom_widgets/menus/categories_drop_down_menu.dart';
import 'package:flutter_app/view/custom_widgets/text/custom_outline_text_form_field.dart';
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
  AddProductViewModel _addProductViewModel;

  @override
  Widget build(BuildContext context) {
    _addProductViewModel = Get.put(AddProductViewModel());

    return Scaffold(
      appBar: CustomAppBar(
        text: 'addProduct'.tr,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<AddProductViewModel>(
          init: _addProductViewModel,
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
    Get.find<AddProductViewModel>().setProductImage(image);
  }

  imgFromGallery() async {
    PickedFile image =
        await ImagePicker().getImage(source: ImageSource.gallery);
    Get.find<AddProductViewModel>().setProductImage(image);
  }

  Widget _productImage() {
    return GestureDetector(
      onTap: () {
        _showPicker();
      },
      child: _addProductViewModel.selectedImage == null
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
          Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 300,
              height: 200,
              child: Image.file(
                File(_addProductViewModel.selectedImage.path),
              )),
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
              text: 'Name',
              hintText: 'Type Product Name Here',
              controller: nameController,
              validateEmptyText: 'Name Empty',
              keyboardType: TextInputType.text,
              labelText: 'ProductName',
            ),
            SizedBox(
              height: 20,
            ),
            CustomOutlinedTextFormField(
              text: 'ProductDescription',
              hintText: 'Type Product Description Here',
              controller: descController,
              maxLines: 6,
              validateEmptyText: 'Description Empty',
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
                    text: 'Price',
                    suffixText: '\$',
                    hintText: '0',
                    validateEmptyText: 'Price Empty',
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    labelText: 'Price',
                  ),
                ),
                Container(
                  width: MediaQuery.of(Get.context).size.width * 0.4,
                  child: CustomOutlinedTextFormField(
                    text: 'Discount Price',
                    hintText: '0',
                    validateEmptyText: 'DiscountPrice Empty',
                    suffixText: '\$',
                    controller: discountPriceController,
                    keyboardType: TextInputType.number,
                    labelText: 'Discount Price',
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
                text: 'Add Product',
                colorBackground: primaryColor,
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
      _addProductViewModel.addProduct(
          nameController.text,
          descController.text,
          int.parse(priceController.text),
          int.parse(discountPriceController.text));
    }
  }
}
