import 'package:flutter/material.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/category_model.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/sub_category_model.dart';
import 'package:tera/data/responses/categories_with_sliders_response.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';

class HomeController extends MainController {
  ProductFilters filter = ProductFilters.Latest;

  List<ProductModel> _filteredProducts = [];

  List<ProductModel> get products => _filteredProducts;

  Future<void> filterProducts() async {
    loading.value = true;
    update();
    _filteredProducts.clear();
    ProductRepo().getFilteredProducts(
      filter,
      state: (dataResource) {
        if (dataResource is Success) {
          _filteredProducts.addAll(dataResource.data as List<ProductModel>);
          print('Best Selling  => ${_filteredProducts.length} items');
          loading.value = false;
          empty.value = _filteredProducts.isEmpty;
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

  // categories and Sub categories to be shared in app screens
  // and to get them into menus right away

  int selectedCategoryIndex = 0;

  CategoryModel categoryModel;
  SubCategoryModel subCategoryModel;

  List<CategoryModel> categories = [];
  List<SubCategoryModel> subCategories = [];
  List<ProductModel> sliderProducts = [];
  ValueNotifier<bool> emptySliders = ValueNotifier(false);
  ValueNotifier<bool> emptyCategories = ValueNotifier(false);
  ValueNotifier<bool> loadingCategories = ValueNotifier(false);

  Future<void> getSliderProducts() async {
    if (sliderProducts.length > 0 && categories.length > 0) {
      return;
    }
    loadingCategories.value = true;
    update();
    ProductRepo().getCategoriesWithSliders(
      state: (dataResource) {
        if (dataResource is Success) {
          CategoriesWithSlidersResponse response = dataResource.data;
          sliderProducts.clear();
          sliderProducts = response.sliders;
          print('Slider count => ${sliderProducts.length} items');

          categories.clear();
          categories.addAll(response.categories);
          print('Categories count => ${categories.length} items');
          loadingCategories.value = false;
          emptyCategories.value = categories.isEmpty;
          emptySliders.value = sliderProducts.isEmpty;
          update();
        } else if (dataResource is Failure) {
          print(dataResource.errorMessage);
          loadingCategories.value = false;
          error.value = true;
          update();
        }
      },
    );
  }

  setCategoryModel(CategoryModel model, {String subCategoryIdToSelect}) async {
    categoryModel = model;
    update();
  }

  setSubCategoryModel(SubCategoryModel model) {
    subCategoryModel = model;
    update();
  }
}
