import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter_app/storage/local_storage.dart';

part 'MyService.chopper.dart';

@ChopperApi()
abstract class MyService extends ChopperService {
  @Get(
      path:
          '/me?fields=name,first_name,last_name,email,picture.height(800)&{token}')
  Future<Response> getFacebookGraph(@Query('access_token') String token);

  @Get(path: '/todos/1')
  Future<Response> getDummyObject();

  static final String token = LocalStorage().getString(LocalStorage.token);

  static MyService create(NetworkBaseUrlType networkBaseUrlType) {
    final client = ChopperClient(
        baseUrl: _getBaseUrl(networkBaseUrlType),
        services: [_$MyService()],
        converter: JsonConverter(),
        errorConverter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          HeadersInterceptor(
              {HttpHeaders.contentTypeHeader: 'application/json'}),
          HeadersInterceptor({HttpHeaders.cacheControlHeader: 'no-Cache'}),
          HeadersInterceptor({HttpHeaders.authorizationHeader: token}),
        ]);

    return _$MyService(client);
  }

  static String _getBaseUrl(NetworkBaseUrlType networkBaseUrlType) {
    switch (networkBaseUrlType) {
      case NetworkBaseUrlType.GraphUrl:
        return graphUrl;
      case NetworkBaseUrlType.MainUrl:
        return baseUrl;
    }
    return baseUrl;
  }
}

enum NetworkBaseUrlType { GraphUrl, MainUrl }

const graphUrl = 'https://graph.facebook.com/v2.12';

const baseUrl = 'https://jsonplaceholder.typicode.com';

//to generate network code by chopper
//run this on terminal to generate code
//  flutter packages pub run build_runner watch
