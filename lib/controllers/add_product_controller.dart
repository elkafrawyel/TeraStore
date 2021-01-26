import 'dart:io';

import 'package:get/get.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/data/models/sub_properity_model.dart';
import 'package:tera/data/requests/add_product_request.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/screens/home_screen/home_screen.dart';

import 'home_controller.dart';
import 'main_controller.dart';

class AddProductController extends MainController {
  Map<String, List<SubProperityModel>> properities = {};

  addMainProperity(String name) {
    properities.addAll({name: []});
    update();
  }

  removeMainProperity(String name) {
    properities.remove(name);
    update();
  }

  void addSubProperity(String key, SubProperityModel subProperityModel) {
    List<SubProperityModel> list = properities[key];
    if (!list.contains(subProperityModel)) list.add(subProperityModel);
    properities.addAll({key: list});

    update();
  }

  void removeSubProperity(String key, SubProperityModel element) {
    List<SubProperityModel> list = properities[key];
    if (list.contains(element)) list.remove(element);
    properities.addAll({key: list});
    update();
  }

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
    if (productImages.length < 2) {
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
      properities,
      state: (dataResource) {
        if (dataResource is Success) {
          loading.value = false;
          update();
          Get.offAll(HomeScreen());
          CommonMethods().showSnackBar('$name ' + 'created'.tr);
        } else if (dataResource is Failure) {
          loading.value = false;
          update();
          print(dataResource.errorMessage);
          CommonMethods().showSnackBar('error'.tr);
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
