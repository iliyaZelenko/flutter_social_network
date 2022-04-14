import 'package:mobx/mobx.dart';
import 'package:rate_club/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:rate_club/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';

part 'auth_presenter.g.dart';

// Класс отвечает за базовые операции аутентификации: вход, выход, получение текущего юзера, статус loggedIn
class AuthPresenter = AuthPresenterBase with _$AuthPresenter;

abstract class AuthPresenterBase with Store {
  final SignInUseCase _signInUseCase;
  final LogOutUseCase _logOutUseCase;
  final ProfilePresenter _profilePresenter;

  AuthPresenterBase({
    required SignInUseCase signInUseCase,
    required ProfilePresenter profilePresenter,
    required LogOutUseCase logOutUseCase,
  })  : _signInUseCase = signInUseCase,
        _logOutUseCase = logOutUseCase,
        _profilePresenter = profilePresenter;

  @computed
  bool get loggedIn => _profilePresenter.profile != null;

  @action
  Future<void> signIn({
    required String username,
    required String password,
  }) async {
    // Не обрабатывать через try/catch, так как используется в auth_flow_presenter
    await _signInUseCase.execute(
      username: username,
      password: password,
    );
    await fetchCurrentUser();
  }

  @action
  Future<void> fetchCurrentUser() async {
    await _profilePresenter.fetch();
  }

  void logOut() {
    _profilePresenter.profile = null;
    _logOutUseCase.execute();
  }
}
