import 'package:worker_manager/worker_manager.dart';

import '../repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository _authRepo;

  LogOutUseCase (AuthRepository this._authRepo);

  void execute () {
    _authRepo.logOut();
  }
}