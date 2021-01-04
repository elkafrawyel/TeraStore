import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/model/favourite_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductService {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference _favouritesRef =
      FirebaseFirestore.instance.collection('Favourites');

  final String userId = FirebaseAuth.instance.currentUser.uid;

  Future<List<QueryDocumentSnapshot>> getProducts(String subCategoryId) async {
    Query query = _productsRef.where('subCategoryId', isEqualTo: subCategoryId);
    var value = await query.get();

    return value.docs;
  }

  //get products in same subCategory
  Future<List<QueryDocumentSnapshot>> getSimilarProducts(
      String subCategoryId, String productId) async {
    Query query =
        _productsRef.where('subCategoryId', isEqualTo: subCategoryId).limit(10);
    var value = await query.get();

    return value.docs;
  }

  addProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {
    //upload image
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('ProductsImages/${productModel.id}');

    reference.putFile(image).then((value) {
      reference.getDownloadURL().then((url) {
        productModel.image = url;
        _productsRef
            .doc(productModel.id)
            .set(productModel.toJson())
            .then((value) {
          callback(true);
        });
      });
    });
  }

  Future<List<QueryDocumentSnapshot>> getMyProducts() async {
    Query query = _productsRef.where('userId', isEqualTo: userId);
    var value = await query.get();
    return value.docs;
  }

  Future<DocumentSnapshot> getProductById(String productId) async {
    var value = await _productsRef.doc(productId).get();
    return value;
  }

  Future<void> checkIfFavourite(
      String productId, Function(bool isFave) check) async {
    FavouriteModel favouriteModel = await getMyFavouriteList();
    if (favouriteModel != null) {
      favouriteModel.myProducts.forEach((element) {
        if (element.id == productId) {
          check(true);
          return;
        }
      });
    } else {
      check(false);
    }
  }

  Future<FavouriteModel> getMyFavouriteList() async {
    DocumentSnapshot snapshot = await _favouritesRef.doc(userId).get();
    if (snapshot.exists) {
      FavouriteModel favouriteModel = FavouriteModel.fromJson(snapshot.data());
      if (favouriteModel != null) {
        print('fav list => ${favouriteModel.myProducts.length}');
        return favouriteModel;
      } else {
        return FavouriteModel(myProducts: []);
      }
    } else {
      return FavouriteModel(myProducts: []);
    }
  }

  addToFavourites(String productId) async {
    bool isExists = false;
    FavouriteModel favouriteModel = await getMyFavouriteList();
    favouriteModel.myProducts.forEach((element) {
      if (element.id == productId) {
        isExists = true;
        return;
      }
    });
    if (!isExists) {
      favouriteModel.myProducts.add(FavouriteProduct(id: productId));
      await _favouritesRef.doc(userId).set(favouriteModel.toJson());
    }
  }

  removeFromFavourites(String productId) async {
    bool isExists = false;
    FavouriteProduct product;
    FavouriteModel favouriteModel = await getMyFavouriteList();
    favouriteModel.myProducts.forEach((element) {
      if (element.id == productId) {
        isExists = true;
        product = element;
        return;
      }
    });
    if (isExists) {
      favouriteModel.myProducts.remove(product);
      await _favouritesRef.doc(userId).set(favouriteModel.toJson());
    }
  }

  filter() {}
}
