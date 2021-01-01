import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/view_model/main_view_model.dart';
import 'package:flutter_app/model/product_model.dart';

class ProductsViewModel extends MainViewModel {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  getProducts(String subCategoryId) async {
    loading.value = true;
    _products.clear();
    ProductService().getProducts(subCategoryId).then((docs) {
      docs.forEach((element) {
        ProductModel productModel = ProductModel.fromJson(element.data());
        productModel.id = element.id;
        _products.add(productModel);
        print('Product model => $productModel');
      });
      loading.value = false;
      if (_products.isEmpty) {
        empty.value = true;
      } else {
        empty.value = false;
      }
      print('Products Size => ${_products.length}');
      update();
    });
  }
}
