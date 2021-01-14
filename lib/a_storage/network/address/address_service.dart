import 'dart:io';

import 'package:chopper/chopper.dart';

part 'address_service.chopper.dart';

@ChopperApi()
abstract class AddressService extends ChopperService {
  @Get(path: '/getGovernorates')
  Future<Response> getGovernorates();

  static AddressService create() {
    final client = ChopperClient(
      baseUrl: baseUrl,
      services: [_$AddressService()],
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
      ],
    );

    return _$AddressService(client);
  }
}

const baseUrl = 'https://xx.hmaserv.online/pshop/api';

//to generate network code by chopper
//run this on terminal to generate code
//  flutter packages pub run build_runner watch
