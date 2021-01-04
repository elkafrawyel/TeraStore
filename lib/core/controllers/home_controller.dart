import 'package:flutter_app/core/services/home_service.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/image_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/screens/main_screen/home_screen.dart';

class HomeController extends MainController {
  ProductFilters filter = ProductFilters.HighPrice;

  int selectedCategoryIndex = 0;
  List<CategoryModel> _categories = [];
  List<ProductModel> _filteredProducts = [];
  List<ProductModel> _sliderProducts = [];

  List<CategoryModel> get categories => _categories;

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
    HomeService().getFilteredProducts(ProductFilters.HighPrice).then((docs) {
      docs.forEach((element) {
        _sliderProducts.add(ProductModel.fromJson(element.data()));
      });
      print('Slider count => ${_sliderProducts.length} items');
      loading.value = false;
      update();
    });
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


}
