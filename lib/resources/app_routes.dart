import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_flow_presenter.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/auth/presentation/sign_in_screen.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/home/presentation/home_screen.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_use_case.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/features/post/presentation/post_screen.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/features/profile_screen/presentation/my_profile/my_profile_screen_presenter.dart';
import 'package:rate_club/features/profile_screen/presentation/other_profile/other_profile_screen_presenter.dart';
import 'package:rate_club/features/profile_screen/presentation/profile_screen.dart';
import 'package:rate_club/rate_club.dart';

mixin AppRoutes {
  static const home = 'home';
  static const auth = 'auth';
  static const post = 'post';
  static const otherProfile = 'other-profile';
  static const myProfile = 'my-profile';
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
    AppRoutes.post: (context) {
      final postId = ModalRoute.of(context)?.settings.arguments as PostId;

      return Provider<PostPresenter>(
        key: ValueKey('provider$postId'),
        child: PostScreen(
          key: ValueKey(postId),
          postId: postId,
          mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
        ),
        create: (_) => PostPresenter(
          getPostUseCase: injector.get<GetPostUseCase>(),
        ),
      );
    },
    AppRoutes.otherProfile: (context) {
      final username = ModalRoute.of(context)?.settings.arguments as String;

      return Provider<AbstractProfileScreenPresenter>(
        key: ValueKey('provider$username'),
        child: ProfileScreen(
          key: ValueKey(username),
          mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
        ),
        create: (_) => OtherProfileScreenPresenter(
          username: username,
          getProfileScreenUseCase: injector.get<GetProfileScreenUseCase>(),
        ),
      );
    },
    AppRoutes.myProfile: (context) => Provider<AbstractProfileScreenPresenter>(
          key: UniqueKey(),
          child: ProfileScreen(
            key: UniqueKey(),
            mainNavigatorKey: injector.get<MainNavigatorKeyType>(),
          ),
          create: (_) => MyProfileScreenPresenter(
            profilePresenter: injector.get<ProfilePresenter>(),
            getProfileScreenUseCase: injector.get<GetProfileScreenUseCase>(),
          ),
        ),
  };
}
