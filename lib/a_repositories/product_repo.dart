import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/model/favourite_model.dart';
import 'package:tera/model/product_model.dart';

class ProductRepo {
  // Future<List<DocumentSnapshot>> getSliders() async {
  //   return [];
  // }

  //get products in same subCategory
  Future<List<DocumentSnapshot>> searchProducts(String searchText) async {
    return [];
  }

  Future<List<DocumentSnapshot>> getSliderProducts() async {
    return [];
  }

  Future<List<DocumentSnapshot>> getFilteredProducts(
      ProductFilters filter) async {
    switch (filter) {
      case ProductFilters.HighPrice:
        return await _highPriceFilter();
      case ProductFilters.LowPrice:
        return await _lowPriceFilter();
      case ProductFilters.Latest:
        print('Todo work');
        return _latestFilter();
      // case ProductFilters.LowRate:
      //   print('Todo work');
      //   return [];
    }
    return await _highPriceFilter();
  }

  Future<List<DocumentSnapshot>> _highPriceFilter() async {
    return [];
  }

  Future<List<DocumentSnapshot>> _lowPriceFilter() async {
    return [];
  }

  Future<List<DocumentSnapshot>> _latestFilter() async {
    return [];
  }

  Future<List<DocumentSnapshot>> getProducts(String subCategoryId) async {
    return [];
  }

  //get products in same subCategory
  Future<List<DocumentSnapshot>> getSimilarProducts(
      String subCategoryId, String productId) async {
    return [];
  }

  addProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {}

  editProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {}

  Future<List<DocumentSnapshot>> getMyProducts() async {
    return [];
  }

  Future<DocumentSnapshot> getProductById(String productId) async {
    return null;
  }

  deleteProduct(String productId) async {}

  Future<void> checkIfFavourite(
      String productId, Function(bool isFave) check) async {}

  Future<FavouriteModel> getMyFavouriteList() async {
    return FavouriteModel(myProducts: []);
  }

  addToFavourites(String productId) async {}

  removeFromFavourites(String productId) async {}
}
