import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/requests/add_product_to_cart_request.dart';
import 'package:tera/data/requests/add_review_request.dart';

part 'products_service.chopper.dart';

@ChopperApi()
abstract class ProductsService extends ChopperService {
  @Get(path: '/getCategories')
  Future<Response> getCategoriesWithSliders();

  @Get(path: '/productFliter/{filterKey}')
  Future<Response> productsFilter(@Path() String filterKey,
      @Query('min') String min, @Query('max') String max);

  @Get(path: '/products/{subCategoryId}')
  Future<Response> getProductsByInCategory(@Path() String subCategoryId);

  @Get(path: '/createUserFavItem/{productId}')
  Future<Response> addRemoveFavourite(@Path() String productId);

  @Get(path: '/userFavItem')
  Future<Response> getFavouriteProducts();

  @Get(path: '/addItemToCart/{productId}')
  Future<Response> addRemoveCart(@Path() String productId);

  @Post(path: '/addItemPropToCart')
  Future<Response> addRemoveCartWithProperities(
      @Body() AddProductToCartRequest addProductToCartRequest);

  @Get(path: '/getCartItems')
  Future<Response> getCartItems();

  @Get(path: '/cartItemPlusMinus/{productId}/{action}')
  Future<Response> cartItemPlusMinus(
      @Path() String productId, @Path() String action);

  @Get(path: '/confirmOrder/{orderId}/{address}')
  Future<Response> confirmOrder(@Path() String orderId, @Path() String address);

  @Get(path: '/singleItem/{productId}')
  Future<Response> singleProduct(@Path() String productId);

  @Get(path: '/getOrders')
  Future<Response> getOrders();

  @Get(path: '/getItemRateComment/{productId}')
  Future<Response> getProductReviews(@Path() String productId);

  @Get(path: '/deleteOrder/{orderId}')
  Future<Response> deleteOrder(@Path() String orderId);

  @Post(path: '/userCreateRateComment')
  Future<Response> addReview(@Body() AddReviewRequest addReviewRequest);

  @Post(path: '/createItem')
  @multipart
  Future<Response> addProduct(
    @Part('sub_cat_id') String subCategoryId,
    @Part('itemName') String itemName,
    @Part('itemDescribe') String itemDescribe,
    @Part('itemPrice') String itemPrice,
    @Part('discountValue') String discountValue,
    @Part('itemCount') String itemCount,
    @PartFile("itemImage") String itemImage,
    @PartFile("image1") String image1,
    @PartFile("image2") String image2,
    @PartFile("image3") String image3,
    @PartFile("image4") String image4,
  );

  static ProductsService create() {
    String apiToken = LocalStorage().getString(LocalStorage.token);
    String language = LocalStorage().getLanguage();
    final client = ChopperClient(
      baseUrl: baseUrl,
      services: [_$ProductsService()],
      errorConverter: JsonConverter(),
      converter: JsonConverter(),
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
