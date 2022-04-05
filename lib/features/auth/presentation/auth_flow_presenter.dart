import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/delays.dart';

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

  // na1se_one/223322Aa
  // email@zlat.ny/password666
  @readonly
  String _username = 'na1se_one';

  @readonly
  String _password = '223322Aa';

  @observable
  bool hidePassword = true;

  @observable
  bool rememberMe = false;

  @action
  setInput({
    String? username,
    String? password,
  }) {
    _username = username ?? _username;
    _password = password ?? _password;
  }

  @action
  Future<void> signIn() async {
    _loading = true;

    try {
      await _authPresenter.signIn(
        username: this._username,
        password: this._password,
      );
    } catch (e) {
      _loading = false;

      rethrow;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    // Нужна задержка, иначе иногда баг вылазит
    Delays.defaultDelayCancelable.next(onValue: (_) {
      _mainNavigatorKey.currentState!.pushReplacementNamed(AppRoutes.home);
    });
  }
}
