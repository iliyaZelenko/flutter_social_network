import 'package:rate_club/resources/app_exception_interface.dart';

class AuthInvalidCredentialsException implements AppExceptionInterface {
  final String message;

  AuthInvalidCredentialsException(this.message);
}
