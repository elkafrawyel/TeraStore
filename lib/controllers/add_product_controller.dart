import 'dart:io';

import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/data/requests/add_product_request.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/home_screen/home_screen.dart';

import 'home_controller.dart';
import 'main_controller.dart';

class AddProductController extends MainController {
  List<File> productImages = [];
  var controller = Get.find<HomeController>();

  setProductImage(File image) async {
    productImages.add(image);
    update();
  }

  addProduct(
    String name,
    String desc,
    String price,
    String discountPrice,
    String quantity,
  ) {
    if (productImages.isEmpty) {
      CommonMethods().showSnackBar('selectImage'.tr);
      return;
    }

    if (controller.categoryModel == null) {
      CommonMethods().showSnackBar('selectCategory'.tr);
      return;
    }

    if (controller.subCategoryModel == null) {
      CommonMethods().showSnackBar('selectSubCategory'.tr);
      return;
    }
    //price validation

    loading.value = true;
    update();

    // int id = DateTime.now().millisecondsSinceEpoch;

    ProductRepo().addProduct(
      AddProductRequest(
          subCategoryId: controller.subCategoryModel.id.toString(),
          discountValue: discountPrice,
          itemCount: quantity,
          itemDescribe: desc,
          itemName: name,
          itemPrice: price),
      productImages,
      state: (dataResource) {
        if (dataResource is Success) {
          loading.value = false;
          update();
          Get.offAll(HomeScreen());
          controller.filterProducts();
          CommonMethods().showSnackBar(name + 'created'.tr);
        } else if (dataResource is Failure) {
          print(dataResource.errorMessage);
        }
      },
    );
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }
}
