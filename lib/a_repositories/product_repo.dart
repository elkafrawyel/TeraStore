import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dioService;
import 'package:dio/dio.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/a_storage/network/products/products_service.dart';
import 'package:tera/data/models/product_model.dart';
import 'package:tera/data/models/sub_properity_model.dart';
import 'package:tera/data/requests/add_product_request.dart';
import 'package:tera/data/responses/categories_with_sliders_response.dart';
import 'package:tera/data/responses/info_response.dart';
import 'package:tera/data/responses/product_details_response.dart';
import 'package:tera/data/responses/product_filter_response.dart';
import 'package:tera/data/responses/seller_info_response.dart';
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

  deleteProduct(String productId,
      {Function(DataResource dataResource) state}) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.deleteProduct(productId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          InfoResponse infoResponse = InfoResponse.fromJson(response.body);
          if (infoResponse.status) {
            state(Success());
          } else {
            state(Failure(errorMessage: 'Failed to delete products'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to delete products'));
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

  getMyProducts({
    Function(DataResource dataResource) state,
  }) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.myProducts(),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ProductsResponse myProductResponse =
              ProductsResponse.fromJson(response.body);
          if (myProductResponse.status) {
            state(Success(data: myProductResponse.data));
          } else {
            state(Failure(errorMessage: 'Failed to get my  Products'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get my Products'));
        }
      },
    );
  }

  getSellerProducts({
    String userId,
    Function(DataResource dataResource) state,
  }) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.getSellerProducts(userId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          ProductsResponse sellerProducts =
              ProductsResponse.fromJson(response.body);
          if (sellerProducts.status) {
            state(Success(data: sellerProducts.data));
          } else {
            state(Failure(errorMessage: 'Failed to get seller Products'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get seller Products'));
        }
      },
    );
  }

  getSellerInformation({
    String userId,
    Function(DataResource dataResource) state,
  }) async {
    ProductsService service = ProductsService.create();
    NetworkMethods().handleResponse(
      call: service.getSellerInformation(userId),
      failed: (message) {
        state(Failure(errorMessage: message));
      },
      whenSuccess: (response) {
        try {
          SellerInfoResponse sellerInfoResponse =
              SellerInfoResponse.fromJson(response.body);
          if (sellerInfoResponse.status) {
            state(Success(data: sellerInfoResponse.information));
          } else {
            state(Failure(errorMessage: 'Failed to get seller information'));
          }
        } catch (e) {
          print(e);
          state(Failure(errorMessage: 'Failed to get seller information'));
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
      Map<String, List<SubProperityModel>> properities,
      {Function(DataResource dataResource) state}) async {
    dioService.Dio dio = dioService.Dio();

    List<dioService.MultipartFile> files = [];
    for (int i = 0; i < images.length; i++) {
      files.add(
        await dioService.MultipartFile.fromFile(images[i].path),
      );
    }

    String properitiesString;
    try {
      print(properities.toString());
      properitiesString = jsonEncode(properities);
      print(properitiesString);
    } catch (e) {
      print(e);
    }

    dioService.FormData formData = dioService.FormData.fromMap({
      "sub_cat_id": addProductRequest.subCategoryId,
      "itemName": addProductRequest.itemName,
      "itemDescribe": addProductRequest.itemDescribe,
      "itemPrice": addProductRequest.itemPrice,
      "properities": properitiesString,
      "discountValue": addProductRequest.discountValue,
      "itemCount": addProductRequest.itemCount,
      "itemImage": await dioService.MultipartFile.fromFile(images[0].path),
      "otherItemImages": files
    });

    String apiToken = LocalStorage().getString(LocalStorage.token);
    String language = LocalStorage().getLanguage();

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.baseUrl = 'https://xx.hmaserv.online/pshop/api';
      options.headers = {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.cacheControlHeader: 'no-Cache',
        HttpHeaders.acceptLanguageHeader: language,
        HttpHeaders.authorizationHeader: 'Bearer $apiToken'
      };
      options.responseType = ResponseType.json;
      options.contentType = 'application/json';
      return options;
    }, onResponse: (Response response) async {
      print('Dio Response ${response.data.toString()}');
      return response;
    }, onError: (DioError e) async {
      print('Error $e');
      return e;
    }));

    dioService.Response response = await dio.post(
      "/createItem",
      data: formData,
    );

    if (response.statusCode == 200) {
      try {
        InfoResponse infoResponse = InfoResponse.fromJson(response.data);
        if (infoResponse.status) {
          state(Success());
        } else {
          state(Failure(errorMessage: 'Failed to Add Product'));
        }
      } catch (e) {
        print(e);
        state(Failure(errorMessage: 'Failed to Add Product'));
      }
    } else {
      state(Failure(errorMessage: 'Failed to Add Product'));
    }
  }

  editProduct(
      ProductModel productModel, File image, Function(bool finish) callback) {}
}
