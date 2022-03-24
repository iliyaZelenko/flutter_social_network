import 'package:auth/auth.dart';
import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:profile/profile.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/delays.dart';

class AuthPresenter extends Presenter {
  AuthUseCase _authUseCase;
  ProfileUseCase _profileUseCase;

  AuthPresenter(this._authUseCase, this._profileUseCase);

  final rememberMe = ValueNotifier(false);
  final hidePassword = ValueNotifier(true);
  String username = 'email@zlat.ny';
  String password = 'password666';
  bool loading = false;

  ValueStream<bool> get loadingStream => stream(() => loading);

  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    return runAndUpdate(
      beforeAction: () => loading = true,
      action: () async {
        await _authUseCase.signIn(
          username: username,
          password: password,
        );
        await _profileUseCase.fetch();
      },
      afterAction: () {
        // loading = false;
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      },
      onError: (_) {
        loading = false;
      },
    );
  }
}
