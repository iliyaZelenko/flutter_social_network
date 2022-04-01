import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_club/features/auth/domain/use_cases/log_out_use_case.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/rate_club.dart';

part 'home_presenter.g.dart';

class HomePresenter = HomePresenterBase with _$HomePresenter;

abstract class HomePresenterBase with Store {
  final GlobalKey<NavigatorState> _mainNavigatorKey;
  final LogOutUseCase _logOutUseCase;

  HomePresenterBase({
    required MainNavigatorKeyType mainNavigatorKey,
    required LogOutUseCase logOutUseCase,
  })  : _mainNavigatorKey = mainNavigatorKey,
        _logOutUseCase = logOutUseCase;

  @observable
  int tapBarNavigationIndex = 0;

  void logOut() {
    _logOutUseCase.execute();
    tapBarNavigationIndex = 0;
    _mainNavigatorKey.currentState!.pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
  }
}
