import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/requests/add_address_request.dart';

part 'general_service.chopper.dart';

@ChopperApi()
abstract class GeneralService extends ChopperService {
  @Get(path: '/getGovernorates')
  Future<Response> getGovernorates();

  @Get(path: '/getUserAdress')
  Future<Response> getAddresses();

  @Get(path: '/deleteUserAdress/{id}')
  Future<Response> deleteUserAdress(@Path() String id);

  @Post(path: '/createUserAdress')
  Future<Response> addAddress(@Body() AddAddressRequest addAddressRequest);

  @Get(path: '/myNotifi')
  Future<Response> getNotification();

  @Get(path: '/privacy_policies')
  Future<Response> getPrivacyPolicies();

  static GeneralService create() {
    String apiToken = LocalStorage().getString(LocalStorage.token);
    // String apiToken =
    //     'OfwVu3ohORAadDVBDqEczSacP9W1Cg3zMhvhE4smslurh6kgpfCmeuOSBMb7DS1SCRNysrwcrwrIbtMktNELqs9byNSw0ZymyPP9';
    String language = LocalStorage().getLanguage();
    final client = ChopperClient(
      baseUrl: baseUrl,
      services: [_$GeneralService()],
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

    return _$GeneralService(client);
  }
}

const baseUrl = 'https://xx.hmaserv.online/pshop/api';

//to generate network code by chopper
//run this on terminal to generate code
//  flutter packages pub run build_runner watch
