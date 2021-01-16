import 'package:tera/a_repositories/product_repo.dart';
import 'package:tera/controllers/main_controller.dart';
import 'package:tera/data/models/product_model.dart';

class ProfileController extends MainController {
  //will contain user data, edit profile, myProducts

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  getMyProducts() async {
    loading.value = true;
    _products.clear();
    // ProductRepo().getMyProducts().then((docs) {
    //   docs.forEach((element) {
    //     ProductModel productModel = ProductModel.fromJson(element.data);
    //     productModel.id = element.documentID;
    //     _products.add(productModel);
    //   });
    //   loading.value = false;
    //   if (_products.isEmpty) {
    //     empty.value = true;
    //   } else {
    //     empty.value = false;
    //   }
    //   print('Products Size => ${_products.length}');
    //   update();
    // });
    loading.value = false;
    update();
  }

  delete(ProductModel productModel) {
    ProductRepo().deleteProduct(productModel.id.toString());
    _products.remove(productModel);
    update();
  }
}
