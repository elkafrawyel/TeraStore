import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/category_service.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/helper/Constant.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/sub_category_model.dart';

class HomeController extends MainController {
  ProductFilters filter = ProductFilters.Latest;

  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _sliderProducts = [];

  List<ProductModel> get products => _filteredProducts;

  List<ProductModel> get sliderProducts => _sliderProducts;

  Future<void> getSliderProducts() async {
    if (_sliderProducts.length > 0) {
      return;
    }
    loading.value = true;
    ProductService().getSliderProducts().then((docs) {
      docs.forEach((element) {
        _sliderProducts.add(ProductModel.fromJson(element.data));
      });
      print('Slider count => ${_sliderProducts.length} items');
      loading.value = false;
      update();
    });
  }

  Future<void> filterProducts() async {
    loading.value = true;
    update();
    _filteredProducts.clear();
    ProductService().getFilteredProducts(filter).then((docs) {
      docs.forEach((element) {
        _filteredProducts.add(ProductModel.fromJson(element.data));
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

  Future<void> getCategories() async {
    if (_categories.length > 0) {
      return;
    }
    loading.value = true;
    CategoryService().getCategories().then((docs) {
      docs.forEach((element) {
        CategoryModel categoryModel = CategoryModel.fromJson(element.data);
        categoryModel.id = element.documentID;
        _categories.add(categoryModel);
      });
      print('Categories => ${_categories.length} items');
      loading.value = false;
      update();
    });
  }

  getSubCategories(String categoryId, {String subCategoryIdToSelect}) async {
    subCategories.clear();
    CategoryService().getSubCategories(categoryId).then((docs) {
      docs.forEach((element) {
        SubCategoryModel subCategoryModel =
            SubCategoryModel.fromJson(element.data);
        subCategoryModel.id = element.documentID;
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
