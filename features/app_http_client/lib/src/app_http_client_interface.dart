import 'dart:async';

import 'package:dio/dio.dart';
import 'package:worker_manager/worker_manager.dart';

// @throws AppHttpException if http error
abstract class AppHttpClientInterface {
  String? get tokenStr;

  Map<String, dynamic>? get authInfo;

  Future<void> init();

  Future<void> clearTokens();

  Cancelable<Response<T>> get<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  Cancelable<Response<T>> post<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  Cancelable<Response<T>> put<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  Cancelable<Response<T>> delete<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  });

  Cancelable<Response<T>> patch<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool? fakeIsolate,
  });

  Cancelable<Response<T>> filesPost<T>({
    String? host,
    String path = '',
    Map<String, String>? headers,
    Map<String, String>? query,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
    required files,
    Map<String, String>? fields,
  });
}
