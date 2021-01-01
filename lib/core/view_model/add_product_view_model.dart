import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/sub_category_service.dart';
import 'package:flutter_app/core/view_model/explore_view_model.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/sub_category_model.dart';
import 'package:flutter_app/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductViewModel extends MainViewModel {
  PickedFile selectedImage;
  CategoryModel categoryModel;
  SubCategoryModel subCategoryModel;
  List<CategoryModel> categories = Get.find<ExploreViewModel>().categories;

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
      CommonMethods().showMessage('Add Product', 'Select Image');
      return;
    }

    if (categoryModel == null) {
      CommonMethods().showMessage('Add Product', 'Select Category');
      return;
    }

    if (subCategoryModel == null) {
      CommonMethods().showMessage('Add Product', 'Select Sub Category');
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
      CommonMethods().showMessage(name, 'created Successfully!');
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
