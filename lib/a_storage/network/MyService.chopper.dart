// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MyService extends MyService {
  _$MyService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MyService;

  @override
  Future<Response<dynamic>> getFacebookGraph(String token) {
    final $url =
        '/me?fields=name,first_name,last_name,email,picture.height(800)&{token}';
    final $params = <String, dynamic>{'access_token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getDummyObject() {
    final $url = '/todos/1';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
