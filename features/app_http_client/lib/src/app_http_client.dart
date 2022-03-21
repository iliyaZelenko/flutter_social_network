import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:isolated_http_client/isolated_http_client.dart' as isolated_client;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:app_http_client/app_http_client.dart';
import 'package:http/http.dart' as http;
import 'tokens_storage.dart';

enum HttpMethod { get, post, put, delete, patch, filePost }

class AppHttpClient extends IsolatedHttpClient implements AppHttpClientInterface {
  final int delayInSeconds;
  final bool fakeIsolate;
  final TokensStorage _tokensStorage;
  final String? defaultHost;

  AppHttpClient({
    bool log = false,
    Duration timeout = const Duration(seconds: 20),
    this.delayInSeconds = 0,
    this.fakeIsolate = false,
    TokensStorage? tokensStorage,
    this.defaultHost,
  })  : _tokensStorage = tokensStorage ?? TokensStorage(),
        super(timeout, log);

  String? get tokenStr => _tokensStorage.token;

  // TODO Ilya: is necessary
  Map<String, String> getHeaders() => {
        HttpHeaders.authorizationHeader: 'Bearer ${_tokensStorage.token}',
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      };

  Cancelable<Response> _performRequest({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    bool handleOnUnauthorized = false,
    required HttpMethod method,
    bool? fakeIsolate,
    Iterable<MultipartBundleFile>? files,
    Map<String, String>? fields,
  }) {
    /// refactor
    final checkedFakeIsolate = fakeIsolate ?? this.fakeIsolate;
    final internalHeaders = <String, String>{}..addAll(headers ?? {});
    final requestHost = host ?? defaultHost!;
    internalHeaders.addAll(getHeaders());

    Cancelable<Response> _request() {
      Cancelable<Response> request;
      switch (method) {
        case HttpMethod.get:
          request = super.get(
            host: requestHost,
            path: path,
            query: query,
            headers: internalHeaders,
            fakeIsolate: checkedFakeIsolate,
          );
          break;
        case HttpMethod.post:
          request = super.post(
            host: requestHost,
            path: path,
            query: query,
            headers: internalHeaders,
            fakeIsolate: checkedFakeIsolate,
            body: body,
          );
          break;
        case HttpMethod.put:
          request = super.put(
            host: requestHost,
            path: path,
            query: query,
            headers: internalHeaders,
            fakeIsolate: checkedFakeIsolate,
            body: body,
          );
          break;
        case HttpMethod.delete:
          request = super.delete(
            host: requestHost,
            path: path,
            query: query,
            headers: internalHeaders,
            fakeIsolate: checkedFakeIsolate,
            body: body,
          );
          break;
        case HttpMethod.patch:
          request = super.patch(
            host: requestHost,
            path: path,
            query: query,
            headers: internalHeaders,
            fakeIsolate: checkedFakeIsolate,
            body: body,
          );
          break;
        case HttpMethod.filePost:
          final checkedQuery = query ?? <String, String>{};
          final checkedFields = fields ?? <String, String>{};
          final checkedHeaders = internalHeaders;
          final checkedFiles = files ?? const [];
          final queryString = makeQuery(checkedQuery);
          request = super.request(
            fakeIsolate: checkedFakeIsolate,
            bundle: MultipartRequestBundle(
              isolated_client.HttpMethod.post,
              '$host$path$queryString',
              checkedQuery,
              checkedHeaders,
              //todo:!!
              files: checkedFiles.toList(),
              fields: checkedFields,
            ),
          );
          break;
      }
      return request;
    }

    return _request().next(
      onValue: (response) async {
        await _rememberTokens(response);
        return response;
      },
      onError: (Object error) {
        if (error is HttpUnauthorizedException && handleOnUnauthorized) {
          return Cancelable.fromFuture(
            http.post(
              Uri.parse('${defaultHost}token/refresh/'),
              body: jsonEncode({
                'refresh': _tokensStorage.refreshToken
              }),
              headers: {
                HttpHeaders.contentTypeHeader: ContentType.json.toString(),
              },
            ),
          ).next(
            onValue: (response) async {
              final json = jsonDecode(response.body);
              print('-------------');
              print(json);
              await _tokensStorage.save(
                json[TokensStorageKeys.token] as String?,
                json[TokensStorageKeys.refreshToken] as String?,
              );
              // Update auth header
              internalHeaders.addAll(getHeaders());
            },
          ).next(
            onValue: (_) {
              return _request();
            },
          );
        }
        return Cancelable.justError(error);
      },
    );
  }

  @override
  Cancelable<Response> get({
    String? host,
    String path = '',
    Map<String, String>? query,
    Map<String, String>? headers,
    bool handleOnUnauthorized = true,
    bool? fakeIsolate,
  }) {
    return _performRequest(
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
    required Iterable<MultipartBundleFile>? files,
    Map<String, String>? fields,
  }) {
    return _performRequest(
      method: HttpMethod.filePost,
      host: host,
      path: path,
      headers: headers,
      query: query,
      handleOnUnauthorized: handleOnUnauthorized,
      files: files,
      fakeIsolate: fakeIsolate,
      fields: fields,
    );
  }

  Future<void> init() => _tokensStorage.init();

  Map<String, dynamic>? get authInfo =>
      _tokensStorage.token.isEmpty ? null : JwtDecoder.decode(_tokensStorage.token);

  Future<void> clearTokens() => _tokensStorage.clear();

  Future<void> _rememberTokens(Response value) async {
    try {
      final body = value.body;
      await _tokensStorage.save(
        body[TokensStorageKeys.token],
        body[TokensStorageKeys.refreshToken],
      );
    } catch (_) {}
  }
}
