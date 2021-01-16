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
