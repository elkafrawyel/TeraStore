import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/home_service.dart';
import 'package:flutter_app/model/product_model.dart';

class SearchController extends MainController {
  List<ProductModel> _searchProducts = [];

  List<ProductModel> get searchProducts => _searchProducts;

  search(String searchText) async {
    loading.value = true;
    update();
    _searchProducts.clear();
    HomeService().searchProducts(searchText).then((docs) {
      docs.forEach((element) {
        _searchProducts.add(ProductModel.fromJson(element.data()));
      });
      print('search count  => ${_searchProducts.length} items');
      loading.value = false;
      empty.value = _searchProducts.isEmpty;
      update();
    });
  }
}
