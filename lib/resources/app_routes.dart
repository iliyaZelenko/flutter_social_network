import 'package:auth/auth.dart';
import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:profile/profile.dart';
import 'package:rate_club/features/auth/auth_presenter.dart';
import 'package:rate_club/features/auth/sign_in_screen.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/features/home/home_screen.dart';

mixin AppRoutes {
  static const home = 'home';
  static const auth = 'auth';
}

getRoutesMap(DependenciesContainer dc) {
  return {
    AppRoutes.home: (_) => PresenterProvider(
          presenter: HomePresenter(),
          child: const HomeScreen(),
        ),
    AppRoutes.auth: (_) => PresenterProvider(
          presenter: AuthPresenter(
            dc.dependency<AuthUseCase>(),
            dc.dependency<ProfileUseCase>(),
          ),
          child: const SignInScreen(),
        ),
  };
}
