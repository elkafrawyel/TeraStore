import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/model/favourite_model.dart';
import 'package:flutter_app/model/product_model.dart';
import 'package:flutter_app/storage/local_storage.dart';

class ProductService {
  final CollectionReference _productsRef =
      Firestore.instance.collection('Products');

  final CollectionReference _favouritesRef =
      Firestore.instance.collection('Favourites');

  final String userId = LocalStorage().getString(LocalStorage.userId);

  Future<List<DocumentSnapshot>> getProducts(String subCategoryId) async {
    Query query = _productsRef.where('subCategoryId', isEqualTo: subCategoryId);
    var value = await query.getDocuments();

    return value.documents;
  }

  //get products in same subCategory
  Future<List<DocumentSnapshot>> getSimilarProducts(
      String subCategoryId, String productId) async {
    Query query =
        _productsRef.where('subCategoryId', isEqualTo: subCategoryId).limit(10);
    var value = await query.getDocuments();

    return value.documents;
  }

  addProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {
    //upload image
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('ProductsImages/${productModel.id}');

    StorageUploadTask task = reference.putFile(image);

    task.onComplete.then((value) {
      reference.getDownloadURL().then((url) {
        productModel.image = url;
        _productsRef
            .document(productModel.id)
            .setData(productModel.toJson())
            .then((value) {
          callback(true);
        });
      });
    });
  }

  editProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {
    //upload image
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('ProductsImages/${productModel.id}');

    if (image != null) {
      StorageUploadTask task = reference.putFile(image);

      task.onComplete.then((value) {
        reference.getDownloadURL().then((url) {
          productModel.image = url;
          _productsRef
              .document(productModel.id)
              .updateData(productModel.toJson())
              .then((value) {
            callback(true);
          });
        });
      });
    } else {
      _productsRef
          .document(productModel.id)
          .updateData(productModel.toJson())
          .then((value) {
        callback(true);
      });
    }
  }

  Future<List<DocumentSnapshot>> getMyProducts() async {
    Query query = _productsRef.where('userId', isEqualTo: userId);
    var value = await query.getDocuments();
    return value.documents.reversed.toList();
  }

  Future<DocumentSnapshot> getProductById(String productId) async {
    var value = await _productsRef.document(productId).get();
    return value;
  }

  deleteProduct(String productId) async {
    await _productsRef.document(productId).delete();
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
    DocumentSnapshot snapshot = await _favouritesRef.document(userId).get();
    if (snapshot.exists) {
      FavouriteModel favouriteModel = FavouriteModel.fromJson(snapshot.data);
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
      await _favouritesRef.document(userId).setData(favouriteModel.toJson());
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
      await _favouritesRef.document(userId).setData(favouriteModel.toJson());
    }
  }

  filter() {}
}
