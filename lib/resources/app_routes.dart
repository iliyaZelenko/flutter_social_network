import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:rate_club/features/auth/sign_in_screen.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/features/home/home_screen.dart';

mixin AppRoutes {
  static const home = 'home';
  static const auth = 'auth';
}

final routesMap = {
  AppRoutes.home: (_) => PresenterProvider(
    presenter: HomePresenter(),
    child: const HomeScreen(),
  ),
  AppRoutes.auth: (_) => const SignInScreen(),
};
