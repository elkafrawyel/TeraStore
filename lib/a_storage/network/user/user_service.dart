import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:tera/a_storage/local_storage.dart';
import 'package:tera/data/requests/edit_profile_request.dart';
import 'package:tera/data/requests/firebase_token_request.dart';
import 'package:tera/data/requests/login_request.dart';
import 'package:tera/data/requests/register_request.dart';
import 'package:tera/data/requests/social_request.dart';

part 'user_service.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {
  @Post(path: '/register')
  Future<Response> register(@Body() RegisterRequest registerRequest);

  @Post(path: '/login')
  Future<Response> login(@Body() LoginRequest loginRequest);

  @Post(path: '/socialSignUp')
  Future<Response> socialSignUp(@Body() SocialRequest socialRequest);

  @Post(path: '/editProfile')
  Future<Response> editProfile(@Body() EditProfileRequest editProfileRequest);

  @Post(path: '/editProfile')
  @multipart
  Future<Response> editProfileWithImage(
    @Part('name') String name,
    @Part('email') String email,
    @Part('phone') String phone,
    @PartFile("image") String image,
  );

  @Post(path: '/createFireBaseToken')
  Future<Response> createFireBaseToken(
      @Body() FirebaseTokenRequest firebaseTokenRequest);

  @Get(path: '/logOut')
  Future<Response> logOut();

  @Get(path: '/profile')
  Future<Response> profile();

  @Get(path: 'me?{fields}&{token}')
  Future<Response> getFacebookGraph(
      @Query('access_token') String token, @Query('fields') String fields);

  static UserService create(NetworkBaseUrlType networkBaseUrlType) {
    String apiToken = LocalStorage().getString(LocalStorage.token);
    String language = LocalStorage().getLanguage();
    final client = ChopperClient(
      baseUrl: _getBaseUrl(networkBaseUrlType),
      services: [_$UserService()],
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

    return _$UserService(client);
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

const graphUrl = 'https://graph.facebook.com/v2.12/';

const baseUrl = 'https://xx.hmaserv.online/pshop/api';

//to generate network code by chopper
//run this on terminal to generate code
//  flutter packages pub run build_runner watch
