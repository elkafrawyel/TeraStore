import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/category_model.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/sub_category_model.dart';
import 'package:tera/data/responses/categories_with_sliders_response.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';

class HomeController extends MainController {
  final drawerController = ZoomDrawerController();
  //============================= Filter ===========================

  ProductFilters filter = ProductFilters.Latest;
  double lowerValue = 0;
  double upperValue = 20000;
  List<ProductModel> filteredProducts = [];

  Future<void> filterProducts() async {
    loading.value = true;
    update();
    filteredProducts.clear();
    ProductRepo().getFilteredProducts(
      filter.value,
      max: upperValue,
      min: lowerValue,
      state: (dataResource) {
        if (dataResource is Success) {
          filteredProducts.addAll(dataResource.data as List<ProductModel>);
          print('Best Selling  => ${filteredProducts.length} items');
          loading.value = false;
          empty.value = filteredProducts.isEmpty;
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

  //=========================== Categories and Sliders ======================
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
    subCategories = categoryModel.subCategories;
    subCategoryModel = null;
    update();
  }

  setSubCategoryModel(SubCategoryModel model) {
    subCategoryModel = model;
    update();
  }

  //========================= favorite Products =============================
  List<ProductModel> favouriteProducts = [];

  addRemoveFavourites(String productId,
      {Function(DataResource dataResource) state}) {
    ProductRepo().addRemoveFavourites(productId, state: state);
  }

  changeFavouriteState(String productId) {
    filteredProducts.forEach((element) {
      if (productId == element.id.toString()) {
        element.isFav = !element.isFav;
        update();
        return;
      }
    });
  }

  // apply item removing from cart to products in home
  changeInCartState(String productId) {
    filteredProducts.forEach((element) {
      if (productId == element.id.toString()) {
        element.inCart = false;
        update();
        return;
      }
    });
  }
}
