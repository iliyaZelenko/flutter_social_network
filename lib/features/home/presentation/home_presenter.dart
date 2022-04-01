import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_routes.dart';

part 'home_presenter.g.dart';

class HomePresenter = HomePresenterBase with _$HomePresenter;

abstract class HomePresenterBase with Store {
  final GlobalKey<NavigatorState> _mainNavigatorKey;
  final AuthPresenter _authPresenter;

  HomePresenterBase({
    required MainNavigatorKeyType mainNavigatorKey,
    required AuthPresenter authPresenter,
  })  : _mainNavigatorKey = mainNavigatorKey,
        _authPresenter = authPresenter;

  @observable
  int tapBarNavigationIndex = 0;

  void logOut() {
    _authPresenter.logOut();
    tapBarNavigationIndex = 0;
    _mainNavigatorKey.currentState!.pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
  }
}
