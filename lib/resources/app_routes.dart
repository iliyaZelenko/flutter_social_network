import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_flow_presenter.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/auth/presentation/sign_in_screen.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/home/presentation/home_screen.dart';
import 'package:rate_club/rate_club.dart';

mixin AppRoutes {
  static const home = 'home';
  static const auth = 'auth';
}

getRoutesMap(InjectorInterface injector) {
  return {
    AppRoutes.home: (_) => Provider<HomePresenter>(
          child: const HomeScreen(),
          create: (_) => HomePresenter(
            mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
            authPresenter: injector.get<AuthPresenter>(),
          ),
        ),
    AppRoutes.auth: (_) => Provider<AuthFlowPresenter>(
          child: const SignInScreen(),
          create: (_) => AuthFlowPresenter(
            mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
            authPresenter: injector.get<AuthPresenter>(),
          ),
        ),
  };
}
