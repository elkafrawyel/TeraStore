import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:tera/a_storage/local_storage.dart';

part 'products_service.chopper.dart';

@ChopperApi()
abstract class ProductsService extends ChopperService {
  @Get(path: '/getCategories')
  Future<Response> getCategoriesWithSliders();

  @Get(path: '/productFliter/{filterKey}')
  Future<Response> productsFilter(@Path() String filterKey);

  @Get(path: '/products/{subCategoryId}')
  Future<Response> getProductsByInCategory(@Path() String subCategoryId);

  @Get(path: '/createUserFavItem/{productId}')
  Future<Response> addRemoveFavourite(@Path() String productId);

  @Get(path: '/userFavItem')
  Future<Response> getFavouriteProducts();

  @Get(path: '/addItemToCart/{productId}')
  Future<Response> addRemoveCart(@Path() String productId);

  @Get(path: '/getCartItems')
  Future<Response> getCartItems();

  @Get(path: '/cartItemPlusMinus/{productId}/{action}')
  Future<Response> cartItemPlusMinus(
      @Path() String productId, @Path() String action);

  @Get(path: '/confirmOrder/{orderId}')
  Future<Response> confirmOrder(@Path() String orderId);

  @Get(path: '/singleItem/{productId}')
  Future<Response> singleProduct(@Path() String productId);

  static ProductsService create() {
    String apiToken = LocalStorage().getString(LocalStorage.token);
    String language = LocalStorage().getLanguage();
    final client = ChopperClient(
      baseUrl: baseUrl,
      services: [_$ProductsService()],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        HeadersInterceptor(
          {HttpHeaders.contentTypeHeader: 'application/json'},
        ),
        HeadersInterceptor(
          {HttpHeaders.acceptHeader: 'application/json'},
        ),
        HeadersInterceptor(
          {HttpHeaders.cacheControlHeader: 'no-Cache'},
        ),
        HeadersInterceptor(
          {HttpHeaders.acceptLanguageHeader: language},
        ),
        HeadersInterceptor(
          {HttpHeaders.authorizationHeader: 'Bearer $apiToken'},
        ),
      ],
    );

    return _$ProductsService(client);
  }
}

const baseUrl = 'https://xx.hmaserv.online/pshop/api';

//to generate network code by chopper
//run this on terminal to generate code
//  flutter packages pub run build_runner watch