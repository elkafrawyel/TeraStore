import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/home_service.dart';
import 'package:flutter_app/core/services/sub_category_service.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/sub_category_model.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';

class HomeController extends MainController {
  ProductFilters filter = ProductFilters.Latest;

  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _sliderProducts = [];

  List<ProductModel> get products => _filteredProducts;

  List<ProductModel> get sliderProducts => _sliderProducts;

  HomeController() {
    getSliderProducts();
    getCategories();
    filterProducts();
  }

  getSliderProducts() async {
    if (_sliderProducts.length > 0) {
      return;
    }
    loading.value = true;
    HomeService().getSliderProducts().then((docs) {
      docs.forEach((element) {
        _sliderProducts.add(ProductModel.fromJson(element.data()));
      });
      print('Slider count => ${_sliderProducts.length} items');
      loading.value = false;
      update();
    });
  }

  filterProducts() async {
    loading.value = true;
    update();
    _filteredProducts.clear();
    HomeService().getFilteredProducts(filter).then((docs) {
      docs.forEach((element) {
        _filteredProducts.add(ProductModel.fromJson(element.data()));
      });
      print('Best Selling  => ${_filteredProducts.length} items');
      loading.value = false;
      empty.value = _filteredProducts.isEmpty;
      update();
    });
  }

// categories and Sub categories to be shared in app screens
  // and to get them into menus right away

  int selectedCategoryIndex = 0;
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;
  CategoryModel categoryModel;
  SubCategoryModel subCategoryModel;

  List<SubCategoryModel> subCategories = [];

  setCategoryModel(CategoryModel model, {String subCategoryIdToSelect}) async {
    categoryModel = model;
    update();
    await getSubCategories(model.id,
        subCategoryIdToSelect: subCategoryIdToSelect);
  }

  setSubCategoryModel(SubCategoryModel model) {
    subCategoryModel = model;
    update();
  }

  getCategories() async {
    if (_categories.length > 0) {
      return;
    }
    loading.value = true;
    HomeService().getCategories().then((docs) {
      docs.forEach((element) {
        CategoryModel categoryModel = CategoryModel.fromJson(element.data());
        categoryModel.id = element.id;
        _categories.add(categoryModel);
      });
      print('Categories => ${_categories.length} items');
      loading.value = false;
      update();
    });
  }

  getSubCategories(String categoryId, {String subCategoryIdToSelect}) async {
    subCategories.clear();
    SubCategoryService().getSubCategories(categoryId).then((docs) {
      docs.forEach((element) {
        SubCategoryModel subCategoryModel =
            SubCategoryModel.fromJson(element.data());
        subCategoryModel.id = element.id;
        subCategories.add(subCategoryModel);
      });

      if (subCategories.isNotEmpty) {
        if (subCategoryIdToSelect != null) {
          for (SubCategoryModel element in subCategories) {
            if (element.id == subCategoryIdToSelect) {
              subCategoryModel = element;
            }
          }
        } else {
          subCategoryModel = subCategories[0];
        }
      }

      print('SubCategories => ${subCategories.length}');

      update();
    });
  }
}
