import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/helper/data_resource.dart';

class FavouriteController extends MainController {
  ProductModel productModel;
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  getMyFavouriteProducts() async {
    loading.value = true;
    update();
    _products.clear();
    ProductRepo().getFavouriteProducts(
      state: (dataResource) {
        if (dataResource is Success) {
          _products.addAll(dataResource.data as List<ProductModel>);
          loading.value = false;
          empty.value = _products.isEmpty;
          update();
        } else if (dataResource is Failure) {
          print(dataResource.errorMessage);
          error.value = true;
          loading.value = false;
          update();
        }
      },
    );
  }
}
