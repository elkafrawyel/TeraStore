import 'dart:io';

import 'package:tera/a_storage/network/products/products_service.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/responses/categories_with_sliders_response.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/data/responses/product_filter_response.dart';
import 'package:tera/helper/CommonMethods.dart';
import 'package:tera/helper/Constant.dart';
import 'package:tera/helper/data_resource.dart';
import 'package:tera/helper/network_methods.dart';

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
          ProductsResponse productFilterResponse =
              ProductsResponse.fromJson(response.body);
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
          ProductsResponse productFilterResponse =
              ProductsResponse.fromJson(response.body);
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

  getFavouriteProducts({Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.getFavouriteProducts(),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ProductsResponse productFilterResponse =
              ProductsResponse.fromJson(response.body);
          if (productFilterResponse.status) {
            state(Success(data: productFilterResponse.data));
          } else {
            state(Failure(errorMessage: 'Failed to get Favourite Products'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get Favourite Products'));
        }
      },
    );
  }

  addRemoveFavourites(String productId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.addRemoveFavourite(productId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            CommonMethods().showSnackBar(infoResponse.message);
            state(Success());
          } else {
            CommonMethods().showSnackBar(infoResponse.message);
            state(Failure(
                errorMessage: 'Failed to add or remove from favourite'));
          }
        } catch (e) {
          print(e);
          state(
              Failure(errorMessage: 'Failed to add or remove from favourite'));
        }
      },
    );
  }

  getSingleProduct(String productId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.singleProduct(productId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ProductDetailsResponse productDetailsResponse =
              ProductDetailsResponse.fromJson(response.body);
          if (productDetailsResponse.status) {
            state(Success(data: productDetailsResponse));
          } else {
            state(Failure(errorMessage: 'Failed to get Product details'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get Product details'));
        }
      },
    );
  }

  // //get products in same subCategory
  // Future<List<DocumentSnapshot>> searchProducts(String searchText) async {
  //   return [];
  // }
  //
  // //get products in same subCategory
  // Future<List<DocumentSnapshot>> getSimilarProducts(
  //     String subCategoryId, String productId) async {
  //   return [];
  // }

  addProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {}

  editProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {}

  deleteProduct(String productId) async {}
}
