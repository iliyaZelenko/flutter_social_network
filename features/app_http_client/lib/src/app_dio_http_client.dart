import 'dart:async';
import 'dart:io';

import 'package:app_http_client/src/app_http_client_interface.dart';
import 'package:app_http_client/src/app_http_exception.dart';
import 'package:app_http_client/src/http_method.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:worker_manager/worker_manager.dart';

import 'dio_flutter_transformer.dart';
import 'tokens_storage.dart';

// @throws AppHttpException if http error
class AppDioHttpClient implements AppHttpClientInterface {
  final TokensStorage _tokensStorage;
  final String? defaultHost;
  final Dio _dio;

  AppDioHttpClient({
    Dio? dio,
    TokensStorage? tokensStorage,
    this.defaultHost,
  })  : _dio = dio ?? Dio(),
        _tokensStorage = tokensStorage ?? TokensStorage();

  String? get tokenStr => _tokensStorage.token;

  Future<void> init() async {
    // See https://stackoverflow.com/a/62911616/5286034
    _dio.transformer = FlutterTransformer();
  }

  Cancelable<Response<T>> _performRequest<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = false,
    required HttpMethod method,
    bool? fakeIsolate,
    Map<String, String>? fields,
  }) {
    final requestHost = host ?? defaultHost!;

    Cancelable<Response<T>> _request() {
      final internalHeaders = <String, String>{}
        ..addAll(headers ?? {})
        ..addAll({
          HttpHeaders.authorizationHeader: 'Bearer ${_tokensStorage.token}',
          HttpHeaders.contentTypeHeader: ContentType('application', 'json', charset: 'utf-8').toString(),
        });

      return Cancelable.fromFuture(
        _dio
            .request<T>(
          requestHost + path,
          data: body,
          queryParameters: query,
          options: Options(
            method: method.toString().split('.').last,
            headers: internalHeaders,
          ),
        )
            .catchError((e) {
          final exception = AppHttpException(
            requestOptions: e.requestOptions,
            error: e.error,
            response: e.response,
            type: _dioExceptionsAdapter(e.type),
          );

          if (e.response!.statusCode == 401) {
            throw AppHttpException401(exception);
          }

          throw exception;
        }),
      );
    }

    return _request().next(
      onValue: (response) async {
        await _rememberTokens(response);
        return response;
      },
    );
  }

  AppHttpErrorType _dioExceptionsAdapter(DioErrorType e) {
    switch (e) {
      case DioErrorType.connectTimeout:
        return AppHttpErrorType.connectTimeout;
      case DioErrorType.sendTimeout:
        return AppHttpErrorType.sendTimeout;
      case DioErrorType.receiveTimeout:
        return AppHttpErrorType.receiveTimeout;
      case DioErrorType.response:
        return AppHttpErrorType.response;
      case DioErrorType.cancel:
        return AppHttpErrorType.cancel;
      case DioErrorType.other:
        return AppHttpErrorType.other;
    }
  }

  @override
  Cancelable<Response<T>> get<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest<T>(
      method: HttpMethod.get,
      host: host,
      path: path,
      query: query,
      headers: headers,
      handleOnUnauthorized: handleOnUnauthorized,
      fakeIsolate: fakeIsolate,
    );
  }

  @override
  Cancelable<Response> post({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest(
      method: HttpMethod.post,
      host: host,
      path: path,
      query: query,
      headers: headers,
      body: body,
      handleOnUnauthorized: handleOnUnauthorized,
      fakeIsolate: fakeIsolate,
    );
  }

  @override
  Cancelable<Response> put({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest(
      method: HttpMethod.put,
      host: host,
      path: path,
      query: query,
      headers: headers,
      body: body,
      handleOnUnauthorized: handleOnUnauthorized,
      fakeIsolate: fakeIsolate,
    );
  }

  @override
  Cancelable<Response> delete({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest(
      method: HttpMethod.delete,
      host: host,
      path: path,
      query: query,
      headers: headers,
      body: body,
      handleOnUnauthorized: handleOnUnauthorized,
      fakeIsolate: fakeIsolate,
    );
  }

  @override
  Cancelable<Response> patch({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool? fakeIsolate,
  }) {
    return _performRequest(
      method: HttpMethod.patch,
      host: host,
      path: path,
      query: query,
      headers: headers,
      body: body,
      fakeIsolate: fakeIsolate,
    );
  }

  Cancelable<Response> filesPost({
    String? host,
    String path = '',
    Map<String, String>? headers,
    Map<String, String>? query,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
    required files,
    Map<String, String>? fields,
  }) {
    return _performRequest(
      method: HttpMethod.filePost,
      host: host,
      path: path,
      headers: headers,
      query: query,
      handleOnUnauthorized: handleOnUnauthorized,
      fakeIsolate: fakeIsolate,
      fields: fields,
    );
  }

  Map<String, dynamic>? get authInfo => _tokensStorage.token.isEmpty ? null : JwtDecoder.decode(_tokensStorage.token);

  Future<void> clearTokens() => _tokensStorage.clear();

  Future<void> _rememberTokens(Response value) async {
    try {
      final data = value.data;

      await _tokensStorage.save(
        data[TokensStorageKeys.token],
        data[TokensStorageKeys.refreshToken],
      );
    } catch (_) {}
  }
}
