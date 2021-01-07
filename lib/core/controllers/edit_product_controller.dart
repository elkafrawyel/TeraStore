import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
import 'my_products_controller.dart';

class EditProductController extends MainController {
  ProductModel product;
  File productImage;

  setProductImage(File image) async {
    productImage = image;
    update();
  }

  editProduct() {
    if (Get.find<HomeController>().categoryModel == null) {
      CommonMethods().showMessage('edit'.tr, 'selectCategory'.tr);
      return;
    }

    if (Get.find<HomeController>().subCategoryModel == null) {
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
          userId: FirebaseAuth.instance.currentUser.uid,
          categoryId: Get.find<HomeController>().categoryModel.id,
          subCategoryId: Get.find<HomeController>().subCategoryModel.id,
          timeStamp: product.id,
        ),
        productImage, (bool) {
      loading.value = false;
      update();
      Get.back();
      Get.find<MyProductsController>().getMyProducts();
    });
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }
}
