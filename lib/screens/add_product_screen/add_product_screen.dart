import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/controllers/add_product_controller.dart';
import 'package:tera/controllers/home_controller.dart';
import 'package:tera/data/models/sub_properity_model.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/screens/custom_widgets/button/custom_button.dart';
import 'package:tera/screens/custom_widgets/custom_appbar.dart';
import 'package:tera/screens/custom_widgets/menus/categories_drop_down_menu.dart';
import 'package:tera/screens/custom_widgets/text/custom_text.dart';

import '../custom_widgets/text/custom_outline_text_form_field.dart';

// ignore: must_be_immutable
class AddProductScreen extends StatelessWidget {
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountValueController = TextEditingController();
  final TextEditingController countController = TextEditingController();

  final controller = Get.find<AddProductController>();
  final homeController = Get.find<HomeController>();

  AddProductScreen() {
    homeController.categoryModel = null;
    homeController.subCategoryModel = null;
    controller.productImages.clear();
    controller.properities.clear();
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
                        height: kDefaultPadding,
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
                    text: 'mainImage'.tr,
                    alignment: AlignmentDirectional.center,
                    fontSize: fontSizeSmall_16 - 2,
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
                      text: 'image'.tr + ' $imageIndex',
                      alignment: AlignmentDirectional.center,
                      fontSize: fontSizeSmall_16 - 2,
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
              keyboardType: TextInputType.number,
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
                    suffixText: 'currency'.tr,
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
                    text: 'discountValue'.tr,
                    hintText: '0',
                    required: false,
                    controller: discountValueController,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    labelText: 'discountPrice'.tr,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            CategoriesDropDownMenu(),
            SizedBox(
              height: kDefaultPadding,
            ),
            Container(
              height: 50,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () async {
                  String name = await _showMainProperityDialog();
                  if (name != null) {
                    controller.addMainProperity(name);
                  }

                  print(controller.properities.toString());
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                label: CustomText(
                  text: 'mainProp'.tr,
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                  fontSize: fontSizeSmall_16,
                ),
                color: LocalStorage().primaryColor(),
                textColor: Colors.white,
              ),
            ),
            Visibility(
              child: _properitiesView(),
              visible: controller.properities.isNotEmpty,
            ),
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
      try {
        String discountValue;
        if (discountValueController.text.isEmpty) {
          discountValue = '0';
        } else {
          int value = int.parse(discountValueController.text);
          value >= 100
              ? CommonMethods().showSnackBar('discountBelow100'.tr)
              : discountValue = value.toString();
        }

        controller.addProduct(
          nameController.text,
          descController.text,
          priceController.text,
          discountValue,
          countController.text,
        );
      } catch (_) {
        CommonMethods().showSnackBar('invalidNumber'.tr);
      }
    }
  }

  Widget _properitiesView() {
    List<Widget> widgets = [];
    controller.properities.forEach((key, value) {
      //Main Properity
      widgets.add(_mainProperityView(key, value));
    });
    return Column(
      children: widgets,
    );
  }

  Widget _mainProperityView(String key, List<SubProperityModel> elements) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          top: kDefaultPadding / 2,
          start: kDefaultPadding / 2,
          end: kDefaultPadding / 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          color: Colors.white,
        ),
        width: MediaQuery.of(Get.context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: kDefaultPadding),
                  child: CustomText(
                    text: key,
                    fontSize: fontSizeSmall_16,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        SubProperityModel subProperity =
                            await _showSubProperityDialog();
                        if (subProperity != null) {
                          controller.addSubProperity(key, subProperity);
                        }
                        print(controller.properities.toString());
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        controller.removeMainProperity(key);
                      },
                    ),
                  ],
                )
              ],
            ),
            _subProperityView(key, elements),
          ],
        ),
      ),
    );
  }

  Widget _subProperityView(String key, List<SubProperityModel> elements) {
    List<Widget> widgets = [];

    elements.forEach((element) {
      widgets.add(
        Padding(
          padding: const EdgeInsetsDirectional.only(
              top: kDefaultPadding / 2,
              start: kDefaultPadding / 2,
              end: kDefaultPadding / 2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding / 2),
              color: Colors.white,
            ),
            width: MediaQuery.of(Get.context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: kDefaultPadding),
                      child: CustomText(
                        text: 'name'.tr +
                            ' : ${element.name}\n' +
                            'price'.tr +
                            ' : ${element.price}',
                        fontSize: fontSizeSmall_16,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            controller.removeSubProperity(key, element);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });

    return Column(
      children: widgets,
    );
  }

  Future<String> _showMainProperityDialog() async {
    TextEditingController controller = TextEditingController();
    String name;
    await showDialog<String>(
      barrierDismissible: true,
      context: Get.context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(
            text: 'mainProp'.tr,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: new TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  decoration: new InputDecoration(
                    hintText: 'name'.tr,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('ok'.tr),
                onPressed: () {
                  name = controller.text;
                  Get.back();
                }),
          ],
        );
      },
    );
    return name;
  }

  Future<SubProperityModel> _showSubProperityDialog() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    String name;
    String price;
    await showDialog<SubProperityModel>(
      barrierDismissible: true,
      context: Get.context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(
            text: 'subProp'.tr,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: 'name'.tr,
                ),
              ),
              SizedBox(
                height: kDefaultPadding / 2,
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: 'price'.tr,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('ok'.tr),
                onPressed: () {
                  name = nameController.text;
                  price = priceController.text;
                  Get.back();
                }),
          ],
        );
      },
    );
    return SubProperityModel(name: name, price: price);
  }
}
