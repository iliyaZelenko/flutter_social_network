import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_flow_presenter.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/auth/presentation/sign_in_screen.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/home/presentation/home_screen.dart';
import 'package:rate_club/features/other_profile/domain/use_cases/get_other_profile_use_case.dart';
import 'package:rate_club/features/other_profile/presentation/other_profile_presenter.dart';
import 'package:rate_club/features/other_profile/presentation/other_profile_screen.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_use_case.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/features/post/presentation/post_screen.dart';
import 'package:rate_club/rate_club.dart';

mixin AppRoutes {
  static const home = 'home';
  static const auth = 'auth';
  static const post = 'post';
  static const otherProfile = 'other-profile';
}

// TODO Ilya: фича сама регистрирует свои роуты
Map<String, WidgetBuilder> getRoutesMap(InjectorInterface injector) {
  return {
    AppRoutes.home: (_) => Provider<HomePresenter>(
          child: const HomeScreen(),
          create: (_) => HomePresenter(),
        ),
    AppRoutes.auth: (_) => Provider<AuthFlowPresenter>(
          child: const SignInScreen(),
          create: (_) => AuthFlowPresenter(
            mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
            authPresenter: injector.get<AuthPresenter>(),
          ),
        ),
    AppRoutes.post: (context) => Provider<PostPresenter>(
          child: PostScreen(
            postId: ModalRoute.of(context)?.settings.arguments as PostId,
            mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
          ),
          create: (_) => PostPresenter(
            getPostUseCase: injector.get<GetPostUseCase>(),
          ),
        ),
    AppRoutes.otherProfile: (context) => Provider<OtherProfilePresenter>(
          child: OtherProfileScreen(
            username: ModalRoute.of(context)?.settings.arguments as String,
            mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
          ),
          create: (_) => OtherProfilePresenter(
            getOtherProfileUseCase: injector.get<GetOtherProfileUseCase>(),
          ),
        ),
  };
}
