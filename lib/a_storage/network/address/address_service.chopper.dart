// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AddressService extends AddressService {
  _$AddressService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AddressService;

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
}
