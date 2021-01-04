import 'package:flutter_app/core/services/explore_service.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/image_model.dart';
import 'package:flutter_app/model/product_model.dart';

class HomeController extends MainController {
  int selectedCategoryIndex = 0;
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<ImageModel> _images = [];

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;

  List<ImageModel> get images => _images;

  HomeController() {
    // getSliders();
    getCategories();
    getBestSellingProducts();
  }

  getSliders() async {
    if (_images.length > 0) {
      return;
    }
    loading.value = true;
    ExploreService().getSliders().then((docs) {
      docs.forEach((element) {
        _images.add(ImageModel.fromJson(element.data()));
      });
      print('Slider Images => ${_images.length} items');
      loading.value = false;
      update();
    });
  }

  getCategories() async {
    if (_categories.length > 0) {
      return;
    }
    loading.value = true;
    ExploreService().getCategories().then((docs) {
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

  getBestSellingProducts() async {
    loading.value = true;
    _products.clear();
    ExploreService().getBestSellingProducts().then((docs) {
      docs.forEach((element) {
        _products.add(ProductModel.fromJson(element.data()));
      });
      print('Best Selling  => ${_products.length} items');
      loading.value = false;
      update();
    });
  }
}
