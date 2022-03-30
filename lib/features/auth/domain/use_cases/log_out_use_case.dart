import '../repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository _authRepo;

  LogOutUseCase (AuthRepository this._authRepo);

  void execute () {
    _authRepo.logOut();
  }
}