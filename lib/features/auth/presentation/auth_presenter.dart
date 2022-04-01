import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_club/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/delays.dart';
import 'package:rate_club/rate_club.dart';

part 'auth_presenter.g.dart';

// TODO Ilya: отдельный AuthFlowPresenter и AuthPresenter, где второй имеет главные методы аутентификации
class AuthPresenter = AuthPresenterBase with _$AuthPresenter;

abstract class AuthPresenterBase with Store {
  final MainNavigatorKeyType _mainNavigatorKey;
  final SignInUseCase _signInUseCase;
  final ProfilePresenter _profilePresenter;

  AuthPresenterBase({
    required MainNavigatorKeyType mainNavigatorKey,
    required SignInUseCase signInUseCase,
    required ProfilePresenter profilePresenter,
  })  : _mainNavigatorKey = mainNavigatorKey,
        _signInUseCase = signInUseCase,
        _profilePresenter = profilePresenter;

  @readonly
  bool _loading = false;

  @readonly
  String _username = 'email@zlat.ny';

  @readonly
  String _password = 'password666';

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
      await _signInUseCase.execute(
        username: this._username,
        password: this._password,
      );
      await _profilePresenter.fetch();
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
