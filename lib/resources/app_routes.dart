import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/auth/presentation/sign_in_screen.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/features/home/home_screen.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';

mixin AppRoutes {
  static const home = 'home';
  static const auth = 'auth';
}

getRoutesMap(Injector injector) {
  return {
    // AppRoutes.home: (_) => PresenterProvider(
    //       presenter: HomePresenter(),
    //       child: const HomeScreen(),
    //     ),
    AppRoutes.auth: (_) => Provider<AuthPresenter>(
          child: const SignInScreen(),
          create: (_) => AuthPresenter(
            mainNavigatorKey: injector.get<GlobalKey<NavigatorState>>(),
            signInUseCase: injector.get<SignInUseCase>(),
            profilePresenter: injector.get<ProfilePresenter>(),
          ),
        ),
  };
}
