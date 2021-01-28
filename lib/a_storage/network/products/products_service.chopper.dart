// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ProductsService extends ProductsService {
  _$ProductsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProductsService;

  @override
  Future<Response<dynamic>> getCategoriesWithSliders() {
    final $url = '/getCategories';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> productsFilter(
      String filterKey, String min, String max) {
    final $url = '/productFliter/$filterKey';
    final $params = <String, dynamic>{'min': min, 'max': max};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> myProducts() {
    final $url = '/myItems';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProductsByInCategory(String subCategoryId) {
    final $url = '/products/$subCategoryId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addRemoveFavourite(String productId) {
    final $url = '/createUserFavItem/$productId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFavouriteProducts() {
    final $url = '/userFavItem';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addRemoveCart(String productId) {
    final $url = '/addItemToCart/$productId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addRemoveCartWithProperities(
      AddProductToCartRequest addProductToCartRequest) {
    final $url = '/addItemPropToCart';
    final $body = addProductToCartRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCartItems() {
    final $url = '/getCartItems';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> cartItemPlusMinus(String productId, String action) {
    final $url = '/cartItemPlusMinus/$productId/$action';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> confirmOrder(String orderId, String address) {
    final $url = '/confirmOrder/$orderId/$address';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> singleProduct(String productId) {
    final $url = '/singleItem/$productId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOrders() {
    final $url = '/getOrders';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getProductReviews(String productId) {
    final $url = '/getItemRateComment/$productId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteOrder(String orderId) {
    final $url = '/deleteOrder/$orderId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteProduct(String productId) {
    final $url = '/deleteItem/$productId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSellerProducts(String userId) {
    final $url = '/sellerItems/$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSellerInformation(String userId) {
    final $url = '/personalItemsInfo/$userId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addReview(AddReviewRequest addReviewRequest) {
    final $url = '/userCreateRateComment';
    final $body = addReviewRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
