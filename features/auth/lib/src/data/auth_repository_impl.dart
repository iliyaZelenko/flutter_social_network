import 'package:auth/src/domain/auth_repository.dart';
import 'package:rate_club/rate_club.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppHttpClientInterface _http;

  AuthRepositoryImpl(this._http);

  @override
  Cancelable<void> signIn({
    required String username,
    required String password,
  }) {
    return _http.post(
      path: 'token/',
      body: {
        'username': username,
        'password': password,
      },
    );
  }

  @override
  void logOut() => _http.clearTokens();
}
