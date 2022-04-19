import 'package:dio/dio.dart';

// Copied from original DioErrorType
enum AppHttpErrorType {
  // It occurs when url is opened timeout.
  connectTimeout,

  // It occurs when url is sent timeout.
  sendTimeout,

  //It occurs when receiving timeout.
  receiveTimeout,

  // When the server response, but with a incorrect status, such as 404, 503...
  response,

  // When the request is cancelled, dio will throw a error with this type.
  cancel,

  // Default error type, Some other Error. In this case, you can
  // use the DioError.error if it is not null.
  other,
}

// Describes the error info  when request failed.
// Copied from original DioError
class AppHttpException implements Exception {
  AppHttpException({
    required this.requestOptions,
    this.response,
    this.type = AppHttpErrorType.other,
    this.error,
  });

  // Request info.
  RequestOptions requestOptions;

  // Response info, it may be `null` if the request can't reach to
  // the http server, for example, occurring a dns error, network is not available.
  Response? response;

  AppHttpErrorType type;

  // The original error/exception object; It's usually not null when `type`
  // is DioErrorType.other
  dynamic error;

  StackTrace? _stackTrace;

  set stackTrace(StackTrace? stack) => _stackTrace = stack;

  StackTrace? get stackTrace => _stackTrace;

  String get message => (error?.toString() ?? '');

  @override
  String toString() {
    var msg = '$runtimeType [$type]: $message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }
    if (_stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }
}

// If 401 (Unauthorized)
class AppHttp401Exception extends AppHttpException {
  AppHttp401Exception(AppHttpException exception)
      : super(
          requestOptions: exception.requestOptions,
          response: exception.response,
          type: exception.type,
          error: exception.error,
        );
}
