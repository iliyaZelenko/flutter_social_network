import 'package:worker_manager/worker_manager.dart';

import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _authRepo;

  SignInUseCase(this._authRepo);

  Cancelable<void> execute({
    required String username,
    required String password,
  }) {
    return _authRepo.signIn(username: username, password: password);
  }
}
