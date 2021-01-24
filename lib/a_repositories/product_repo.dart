import 'dart:io';

import 'package:tera/a_storage/network/products/products_service.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/requests/add_product_request.dart';
import 'package:tera/data/responses/categories_with_sliders_response.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/data/responses/product_filter_response.dart';
import 'package:tera/helper/CommonMethods.dart';
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

  getFilteredProducts(
    String value, {
    double min,
    double max,
    Function(DataResource dataResource) state,
  }) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.productsFilter(value, min.toString(), max.toString()),
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

  addProduct(AddProductRequest addProductRequest, List<File> images,
      {Function(DataResource dataResource) state}) {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.addProduct(
        addProductRequest.subCategoryId,
        addProductRequest.itemName,
        addProductRequest.itemDescribe,
        addProductRequest.itemPrice,
        addProductRequest.discountValue,
        addProductRequest.itemCount,
        images[0].path,
        images[1].path,
        images[2].path,
        images[3].path,
        images[4].path,
      ),
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
            state(Failure(errorMessage: 'Failed to Add Product'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to Add Product'));
        }
      },
    );
  }

  editProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {}

  deleteProduct(String productId) async {}
}
