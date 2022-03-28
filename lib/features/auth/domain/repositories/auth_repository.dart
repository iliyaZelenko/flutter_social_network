import 'package:rate_club/rate_club.dart';

abstract class AuthRepository {
  Cancelable<void> signIn({
    required String username,
    required String password,
  });

  void logOut();
}
