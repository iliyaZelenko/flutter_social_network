import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_club/features/auth/exceptions/auth_invalid_credentials_exception.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/app_routes.dart';

part 'auth_flow_presenter.g.dart';

// Отвечает за экраны входа, регистрации, информацию которая там вводится
class AuthFlowPresenter = AuthFlowPresenterBase with _$AuthFlowPresenter;

abstract class AuthFlowPresenterBase with Store {
  final MainNavigatorKeyType _mainNavigatorKey;
  final AuthPresenter _authPresenter;

  AuthFlowPresenterBase({
    required MainNavigatorKeyType mainNavigatorKey,
    required AuthPresenter authPresenter,
  })  : _mainNavigatorKey = mainNavigatorKey,
        _authPresenter = authPresenter;

  @readonly
  bool _loading = false;

  // na1se_one/123456qwer
  // email@zlat.ny/password666
  @readonly
  String _username = 'arttest10';

  @readonly
  String _password = 'arturkh123';

  @readonly
  String? _error;

  @observable
  bool hidePassword = true;

  @observable
  bool rememberMe = false;

  @action
  void setInput({
    String? username,
    String? password,
  }) {
    _username = username ?? _username;
    _password = password ?? _password;
  }

  @action
  Future<void> signIn() async {
    _error = null;
    _loading = true;

    try {
      await _authPresenter.signIn(
        username: _username,
        password: _password,
      );

      FocusManager.instance.primaryFocus?.unfocus();
      // Нужна задержка, иначе иногда баг вылазит
      Durations.defaultDurationCancelable.next(onValue: (_) {
        _mainNavigatorKey.currentState!.pushReplacementNamed(AppRoutes.home);
      });
    } catch (e) {
      _loading = false;

      if (e is AuthInvalidCredentialsException) {
        _error = e.message;
      } else {
        rethrow;
      }
    }
  }
}
