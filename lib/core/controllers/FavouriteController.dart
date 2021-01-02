import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/model/favourite_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/user_model.dart';

class FavouriteController extends MainController {
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  getMyFavouriteProducts() async {
    loading.value = true;
    _products.clear();
    FavouriteModel favouriteModel = await ProductService().getMyFavouriteList();
    for (FavouriteProduct element in favouriteModel.myProducts) {
      ProductModel model = await getProductById(element.id);
      _products.add(model);
      print('element id${element.id}');
    }
    loading.value = false;
    if (_products.isEmpty) {
      empty.value = true;
    } else {
      empty.value = false;
    }
    update();
  }

  Future<ProductModel> getProductById(String productId) async {
    ProductModel productModel;
    DocumentSnapshot snapshot =
        await ProductService().getProductById(productId);
    if (snapshot.exists) {
      productModel = ProductModel.fromJson(snapshot.data());
      //get product owner
      DocumentSnapshot userSnapShot =
          await UserService().getUser(productModel.userId);
      UserModel owner = UserModel.fromJson(userSnapShot.data());
      productModel.owner = owner;

      productModel.isFav = true;
      // print('product : $productModel');
      // print('owner : $owner');
      // print('Products Size => ${_products.length}');

    }
    return productModel;
  }
}
