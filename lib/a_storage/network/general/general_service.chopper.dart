// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GeneralService extends GeneralService {
  _$GeneralService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GeneralService;

  @override
  Future<Response<dynamic>> getGovernorates() {
    final $url = '/getGovernorates';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAddresses() {
    final $url = '/getUserAdress';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteUserAdress(String id) {
    final $url = '/deleteUserAdress/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addAddress(AddAddressRequest addAddressRequest) {
    final $url = '/createUserAdress';
    final $body = addAddressRequest;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNotification() {
    final $url = '/myNotifi';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPrivacyPolicies() {
    final $url = '/privacy_policies';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
