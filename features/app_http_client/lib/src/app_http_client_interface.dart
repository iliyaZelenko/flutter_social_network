import 'dart:async';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:app_http_client/app_http_client.dart';


abstract class AppHttpClientInterface {
  String? get tokenStr;

  Map<String, dynamic>? get authInfo;

  Future<void> init();

  Future<void> clearTokens();

  Map<String, String> getHeaders();

  @override
  Cancelable<Response> get({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  @override
  Cancelable<Response> post({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  @override
  Cancelable<Response> put({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  @override
  Cancelable<Response> delete({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  @override
  Cancelable<Response> patch({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool? fakeIsolate,
  });

  Cancelable<Response> filesPost({
    String? host,
    String path = '',
    Map<String, String>? headers,
    Map<String, String>? query,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
    required Iterable<MultipartBundleFile>? files,
    Map<String, String>? fields,
  });
}
