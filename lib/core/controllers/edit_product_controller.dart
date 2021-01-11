import 'dart:io';

import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/controllers/profile_controller.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/storage/local_storage.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class EditProductController extends MainController {
  ProductModel product;
  File productImage;
  var controller = Get.find<HomeController>();

  setProductImage(File image) async {
    productImage = image;
    update();
  }

  editProduct() {
    if (controller.categoryModel == null) {
      CommonMethods().showMessage('edit'.tr, 'selectCategory'.tr);
      return;
    }

    if (controller.subCategoryModel == null) {
      CommonMethods().showMessage('edit'.tr, 'selectSubCategory'.tr);
      return;
    }
    //price validation
    loading.value = true;
    update();

    ProductService().editProduct(
        ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          image: product.image,
          discountPrice: product.discountPrice,
          userId: LocalStorage().getString(LocalStorage.userId),
          categoryId: controller.categoryModel.id,
          subCategoryId: controller.subCategoryModel.id,
          timeStamp: product.id,
        ),
        productImage, (bool) {
      loading.value = false;
      update();
      Get.back();
      Get.find<ProfileController>().getMyProducts();
    });
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }
}
