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

class AppDioHttpClient implements AppHttpClientInterface {
  final TokensStorage _tokensStorage;
  final String? defaultHost;
  final Dio _dio;

  AppDioHttpClient({
    Dio? dio,
    TokensStorage? tokensStorage,
    this.defaultHost,
  })  : _dio = dio ??
            Dio(BaseOptions(
              validateStatus: (int? status) {
                // Fix https://github.com/flutterchina/dio/issues/995#issuecomment-739902537
                return status != null && status >= 100 && status <= 400;
              },
            )),
        _tokensStorage = tokensStorage ?? TokensStorage();

  @override
  String? get tokenStr => _tokensStorage.token;

  @override
  Future<void> init() async {
    // See https://stackoverflow.com/a/62911616/5286034
    _dio.transformer = FlutterTransformer();
    await _tokensStorage.init();
  }

  // @throws AppHttpException if http error
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
          if (_tokensStorage.token != null) HttpHeaders.authorizationHeader: 'Bearer ${_tokensStorage.token}',
          HttpHeaders.contentTypeHeader: ContentType('application', 'json', charset: 'utf-8').toString(),
          // HttpHeaders.acceptHeader: ContentType('application', 'json', charset: 'utf-8').toString(),
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
          if (e is DioError && e.response != null) {
            final exception = AppHttpException(
              requestOptions: e.requestOptions,
              error: e.error,
              response: e.response,
              type: _dioExceptionsAdapter(e.type),
            );

            if (e.response!.statusCode == 401) {
              throw AppHttp401Exception(exception);
            }

            throw exception;
          }

          throw e;
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
  Cancelable<Response<T>> post<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest<T>(
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
  Cancelable<Response<T>> put<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest<T>(
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
  Cancelable<Response<T>> delete<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest<T>(
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
  Cancelable<Response<T>> patch<T>({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool? fakeIsolate,
  }) {
    return _performRequest<T>(
      method: HttpMethod.patch,
      host: host,
      path: path,
      query: query,
      headers: headers,
      body: body,
      fakeIsolate: fakeIsolate,
    );
  }

  @override
  Cancelable<Response<T>> filesPost<T>({
    String? host,
    String path = '',
    Map<String, String>? headers,
    Map<String, String>? query,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
    required files,
    Map<String, String>? fields,
  }) {
    return _performRequest<T>(
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

  @override
  Map<String, dynamic>? get authInfo => _tokensStorage.token == null ? null : JwtDecoder.decode(_tokensStorage.token!);

  @override
  Future<void> clearTokens() => _tokensStorage.clear();

  Future<void> _rememberTokens(Response value) async {
    try {
      final data = value.data;

      await _tokensStorage.save(
        data[TokensStorageKeys.token] as String?,
        data[TokensStorageKeys.refreshToken] as String?,
      );
    } catch (_) {}
  }
}
