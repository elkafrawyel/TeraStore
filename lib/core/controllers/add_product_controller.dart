import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/sub_category_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/sub_category_model.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'home_controller.dart';
import 'main_controller.dart';

class AddProductController extends MainController {
  PickedFile selectedImage;
  CategoryModel categoryModel;
  SubCategoryModel subCategoryModel;
  List<CategoryModel> categories = Get.find<HomeController>().categories;

  List<SubCategoryModel> subCategories = [];

  setCategoryModel(CategoryModel model) async {
    categoryModel = model;
    update();
    await getSubCategories(model.id);
  }

  setSubCategoryModel(SubCategoryModel model) {
    subCategoryModel = model;
    update();
  }

  setProductImage(PickedFile image) {
    selectedImage = image;
    update();
  }

  addProduct(String name, String desc, int price, int discountPrice) {
    if (selectedImage == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectImage'.tr);
      return;
    }

    if (categoryModel == null) {
      CommonMethods().showMessage('addProduct'.tr, 'selectCategory'.tr);
      return;
    }

    if (subCategoryModel == null) {
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
          userId: FirebaseAuth.instance.currentUser.uid,
          subCategoryId: subCategoryModel.id,
          timeStamp: id.toString(),
        ),
        selectedImage, (bool) {
      loading.value = false;
      update();
      Get.offAll(HomeScreen());
      Get.find<HomeController>().getBestSellingProducts();
      CommonMethods().showMessage(name, 'created'.tr);
    });
  }

  getSubCategories(String categoryId) async {
    subCategories.clear();
    SubCategoryService().getSubCategories(categoryId).then((docs) {
      docs.forEach((element) {
        SubCategoryModel subCategoryModel =
            SubCategoryModel.fromJson(element.data());
        subCategoryModel.id = element.id;
        subCategories.add(subCategoryModel);
      });
      if (subCategories.isNotEmpty) subCategoryModel = subCategories[0];
      print('SubCategories => ${subCategories.length}');
      update();
    });
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }
}
