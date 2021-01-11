import 'package:flutter_app/a_repositories/product_repo.dart';
import 'package:flutter_app/controllers/main_controller.dart';
import 'package:flutter_app/model/product_model.dart';

class FavouriteController extends MainController {
  ProductModel productModel;
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  getMyFavouriteProducts() async {
    loading.value = true;
    update();
    _products.clear();

    loading.value = false;
    if (_products.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    update();
  }

  removeFromFavourites(ProductModel productModel) async {
    await ProductRepo().removeFromFavourites(productModel.id);
    _products.remove(productModel);

    empty.value = _products.isEmpty;
    update();
  }
}
