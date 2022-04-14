import 'package:app_http_client/app_http_client.dart';
import 'package:rate_club/features/auth/exceptions/auth_invalid_credentials_exception.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepo;

  SignInUseCase(this._authRepo);

  Future<void> execute({
    required String username,
    required String password,
  }) async {
    try {
      return await _authRepo.signIn(username: username, password: password);
    } on AppHttp401Exception catch (e) {
      throw AuthInvalidCredentialsException(e.response?.data?['detail'] as String? ?? 'Invalid credentials');
    }
  }
}
