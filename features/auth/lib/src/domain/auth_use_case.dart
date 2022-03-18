import 'package:auth/src/domain/auth_repository.dart';
import 'package:rate_club/rate_club.dart';

class AuthUseCase {
  final AuthRepository _repository;

  AuthUseCase(this._repository);

  Cancelable<void> signIn({
    required String username,
    required String password,
  }) {
    return _repository.signIn(
      username: username,
      password: password,
    );
  }
}
