import 'package:auth/src/domain/auth_repository.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/src/cancelable/cancelable.dart';

class AuthRepositoryMock implements AuthRepository {
  final AppHttpClientInterface _http;

  AuthRepositoryMock(this._http);

  @override
  Cancelable<void> signIn({required String username, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  void logOut() {
    // TODO: implement logOut
  }
}
