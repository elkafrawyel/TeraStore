import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tera/a_storage/network/products/products_service.dart';
import 'package:tera/data/responses/categories_with_sliders_response.dart';
import 'package:tera/data/responses/product_filter_response.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';
import 'package:tera/model/favourite_model.dart';

import 'file:///F:/Apps/My%20Flutter%20Apps/TeraStore/lib/data/models/product_model.dart';

class ProductRepo {
  getCategoriesWithSliders({Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();

    NetworkMethods().handleResponse(
      call: service.getCategoriesWithSliders(),
      whenSuccess: (response) {
        try {
          CategoriesWithSlidersResponse categoriesWithSlidersResponse =
              CategoriesWithSlidersResponse.fromJson(response.body);
          if (categoriesWithSlidersResponse.status) {
            state(Success(data: categoriesWithSlidersResponse));
          } else {
            state(
                Failure(errorMessage: 'Failed to get categories and sliders'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get categories and sliders'));
        }
      },
    );
  }

  getFilteredProducts(ProductFilters filter,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.productsFilter(filter.value),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ProductFilterResponse productFilterResponse =
              ProductFilterResponse.fromJson(response.body);
          if (productFilterResponse.status) {
            state(Success(data: productFilterResponse.data));
          } else {
            state(Failure(errorMessage: 'Failed to Filter Products'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to Filter Products'));
        }
      },
    );
  }

  getProductsInCategory(int subCategoryId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.getProductsByInCategory(subCategoryId.toString()),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ProductFilterResponse productFilterResponse =
              ProductFilterResponse.fromJson(response.body);
          if (productFilterResponse.status) {
            state(Success(data: productFilterResponse.data));
          } else {
            state(Failure(errorMessage: 'Failed to get Products in category'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get Products in category'));
        }
      },
    );
  }

  //get products in same subCategory
  Future<List<DocumentSnapshot>> searchProducts(String searchText) async {
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
