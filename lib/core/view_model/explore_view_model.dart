import 'package:flutter_app/core/services/explore_service.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/model/category_model.dart';
import 'package:flutter_app/model/image_model.dart';
import 'package:flutter_app/model/product_model.dart';

class ExploreViewModel extends MainViewModel {
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  List<ImageModel> _images = [];

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;

  List<ImageModel> get images => _images;

  ExploreViewModel() {
    getSliders();
    getCategories();
    getBestSellingProducts();
  }

  getSliders() async {
    loading.value = true;
    ExploreService().getSliders().then((docs) {
      docs.forEach((element) {
        _images.add(ImageModel.fromJson(element.data()));
      });
      print('Images List => ${_images.length}');
      loading.value = false;
      update();
    });
  }

  getCategories() async {
    loading.value = true;
    ExploreService().getCategories().then((docs) {
      docs.forEach((element) {
        CategoryModel categoryModel = CategoryModel.fromJson(element.data());
        categoryModel.id = element.id;
        _categories.add(categoryModel);
      });
      print('Categories List => ${_categories.length}');
      loading.value = false;
      update();
    });
  }

  getBestSellingProducts() async {
    loading.value = true;
    ExploreService().getBestSellingProducts().then((docs) {
      docs.forEach((element) {
        _products.add(ProductModel.fromJson(element.data()));
      });
      print('Best Selling List => ${_products.length}');
      loading.value = false;
      update();
    });
  }
}
