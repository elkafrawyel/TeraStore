// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$UserService extends UserService {
  _$UserService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = UserService;

  @override
  Future<Response<dynamic>> register(RegisterRequest registerRequest) {
    final $url = '/register';
    final $body = registerRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> login(LoginRequest loginRequest) {
    final $url = '/login';
    final $body = loginRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> socialSignUp(SocialRequest socialRequest) {
    final $url = '/socialSignUp';
    final $body = socialRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> editProfile(EditProfileRequest editProfileRequest) {
    final $url = '/editProfile';
    final $body = editProfileRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> editProfileWithImage(
      String name, String email, String phone, String image) {
    final $url = '/editProfile';
    final $parts = <PartValue>[
      PartValue<String>('name', name),
      PartValue<String>('email', email),
      PartValue<String>('phone', phone),
      PartValueFile<String>('image', image)
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createFireBaseToken(
      FirebaseTokenRequest firebaseTokenRequest) {
    final $url = '/createFireBaseToken';
    final $body = firebaseTokenRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> logOut() {
    final $url = '/logOut';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> profile() {
    final $url = '/profile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFacebookGraph(String token, String fields) {
    final $url = 'me?{fields}&{token}';
    final $params = <String, dynamic>{'access_token': token, 'fields': fields};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
