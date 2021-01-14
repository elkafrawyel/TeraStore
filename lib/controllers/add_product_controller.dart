import 'dart:io';

import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/model/product_model.dart';
import 'package:tera/screens/home_screen/home_screen.dart';

import 'home_controller.dart';
import 'main_controller.dart';

class AddProductController extends MainController {
  File productImage;
  var controller = Get.find<HomeController>();

  setProductImage(File image) async {
    productImage = image;
    update();
  }

  addProduct(String name, String desc, int price, int discountPrice) {
    if (productImage == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectImage'.tr);
      return;
    }

    if (controller.categoryModel == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectCategory'.tr);
      return;
    }

    if (controller.subCategoryModel == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectSubCategory'.tr);
      return;
    }
    //price validation

    loading.value = true;
    update();
    int id = DateTime.now().millisecondsSinceEpoch;
    print(id.toString());
    ProductRepo().addProduct(
        ProductModel(
          id: id.toString(),
          name: name,
          description: desc,
          price: price,
          discountPrice: discountPrice,
          userId: 'LocalStorage().getString(LocalStorage.userId)',
          categoryId: controller.categoryModel.id,
          subCategoryId: controller.subCategoryModel.id,
          timeStamp: id.toString(),
        ),
        productImage, (bool) {
      loading.value = false;
      update();
      Get.offAll(HomeScreen());
      controller.filterProducts();
      CommonMethods().showMessage(name, 'created'.tr);
    });
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }
}
