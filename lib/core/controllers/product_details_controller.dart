import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/core/controllers/main_controller.dart';
import 'package:flutter_app/core/services/product_service.dart';
import 'package:flutter_app/core/services/user_service.dart';
import 'package:flutter_app/helper/CommonMethods.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/model/user_model.dart';

class ProductDetailsController extends MainController {
  ProductModel productModel;

  getProductById(String productId) async {
    loading.value = true;
    update();
    DocumentSnapshot snapshot =
        await ProductService().getProductById(productId);
    if (snapshot.exists) {
      productModel = ProductModel.fromJson(snapshot.data());
      //get product owner
      DocumentSnapshot userSnapShot =
          await UserService().getUser(productModel.userId);
      UserModel owner = UserModel.fromJson(userSnapShot.data());
      productModel.owner = owner;
      //check if is favourite
      await checkIfFavourite(productId);
      print('product : $productModel');
      print('owner : $owner');
      loading.value = false;
      update();
    }
  }

  Future<void> checkIfFavourite(String productId) async {
    await ProductService().checkIfFavourite(productId, (isFave) {
      productModel.isFav = isFave;
    });
  }

  addToFavourites(String productId) async {
    await ProductService().addToFavourites(productId);
    productModel.isFav = true;
    CommonMethods()
        .showMessage(productModel.name, 'Added to your favourite list');
    update();
  }

  removeFromFavourites(String productId) async {
    await ProductService().removeFromFavourites(productId);
    productModel.isFav = false;
    CommonMethods()
        .showMessage(productModel.name, 'Removed from your favourite list');
    update();
  }
}
