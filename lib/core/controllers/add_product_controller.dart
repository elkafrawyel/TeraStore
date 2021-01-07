import 'dart:io';

import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'main_controller.dart';

class AddProductController extends MainController {
  File productImage;

  setProductImage(File image) async {
    // File file =
    //     await ImageConverter().compressProductBigImage(image.path);
    // File file1 = await ImageConverter()
    //     .compressProductSmallImage(image.path);
    // productBigImage = file;
    productImage = image;
    update();
  }

  addProduct(String name, String desc, int price, int discountPrice) {
    if (productImage == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectImage'.tr);
      return;
    }

    if (Get.find<HomeController>().categoryModel == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectCategory'.tr);
      return;
    }

    if (Get.find<HomeController>().subCategoryModel == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectSubCategory'.tr);
      return;
    }
    //price validation

    loading.value = true;
    update();
    int id = DateTime.now().millisecondsSinceEpoch;
    print(id.toString());
    ProductService().addProduct(
        ProductModel(
          id: id.toString(),
          name: name,
          description: desc,
          price: price,
          discountPrice: discountPrice,
          userId: Get.find<MainController>().user.id,
          categoryId: Get.find<HomeController>().categoryModel.id,
          subCategoryId: Get.find<HomeController>().subCategoryModel.id,
          timeStamp: id.toString(),
        ),
        productImage, (bool) {
      loading.value = false;
      update();
      Get.offAll(HomeScreen());
      Get.find<HomeController>().filterProducts();
      CommonMethods().showMessage(name, 'created'.tr);
    });
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }
}
