import 'package:flutter/material.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/category_model.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/data_resource.dart';

class ProductsController extends MainController {
  ValueNotifier<bool> loadingSubCategories = ValueNotifier(false);
  ValueNotifier<bool> emptySubCategories = ValueNotifier(false);

  CategoryModel categoryModel;
  int selectedSubCategoryIndex = 0;

  List<ProductModel> products = [];

  changeSubCategory(int index) {
    selectedSubCategoryIndex = index;
    empty.value = categoryModel.subCategories.isEmpty;
    update();
    getProducts();
  }

  getProducts() async {
    loading.value = true;
    update();
    products.clear();
    int subCategoryId =
        categoryModel.subCategories[selectedSubCategoryIndex].id;
    ProductRepo().getProductsInCategory(
      subCategoryId,
      state: (dataResource) {
        if (dataResource is Success) {
          products.addAll(dataResource.data as List<ProductModel>);
          print('Products in category => ${products.length} items');
          loading.value = false;
          empty.value = products.isEmpty;
          update();
        } else if (dataResource is Failure) {
          print(dataResource.errorMessage);
          loading.value = false;
          error.value = true;
          update();
        }
      },
    );
  }
}
