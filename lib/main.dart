import 'package:app_http_client/app_http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injector/injector.dart';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/env/env_feature.dart';
import 'package:rate_club/features/env/env_registry.dart';
import 'package:rate_club/features/env/env_variables.dart';
import 'package:rate_club/features/feed/feed_feature.dart';
import 'package:rate_club/features/http/http_feature.dart';
import 'package:rate_club/features/post/post_feature.dart';
import 'package:rate_club/features/profile/profile_feature.dart';
import 'package:rate_club/rate_club.dart';

import 'features/auth/auth_feature.dart';
import 'features/feature_invoker.dart';
import 'features/profile/presentation/profile_presenter.dart';
import 'resources/app_colors.dart';
import 'resources/app_routes.dart';
import 'resources/app_text_styles.dart';
import 'resources/common_widgets/app_drawer.dart';
import 'resources/emojis.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final injector = await _setupEnvironment();
  final navigatorKey = injector.get<MainNavigatorKeyType>();
  final authPresenter = injector.get<AuthPresenter>();

  await authPresenter.fetchCurrentUser();

  final initialRoute = authPresenter.loggedIn ? AppRoutes.home : AppRoutes.auth;

  runApp(
    MultiProvider(
      providers: [
        Provider<InjectorInterface>(create: (_) => injector),
        Provider<ProfilePresenter>(create: (_) => injector.get<ProfilePresenter>()),
        Provider<AuthPresenter>(create: (_) => injector.get<AuthPresenter>()),
        Provider<AppDrawerController>(
          create: (_) => AppDrawerController(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Material(
          color: AppColors.black80,
          child: ScrollConfiguration(
            behavior: const _Bouncing(),
            child: CupertinoApp(
              navigatorKey: navigatorKey,
              theme: const CupertinoThemeData(
                brightness: Brightness.dark,
                textTheme: CupertinoTextThemeData(
                    navLargeTitleTextStyle: AppTextStyles.semiBold16,
                    primaryColor: AppColors.black80,
                    textStyle: TextStyle(color: AppColors.black80)),
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
              initialRoute: initialRoute,
              home: nil,
              builder: (ctx, widget) {
                return Stack(
                  children: [
                    const Text(
                      emojis,
                      style: TextStyle(fontSize: 5),
                      textScaleFactor: 1,
                    ),
                    widget!,
                    Observer(
                      builder: (_) {
                        return authPresenter.loggedIn
                            ? AppDrawer(
                                controller: Provider.of<AppDrawerController>(ctx),
                                mainNavigatorKey: navigatorKey,
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                );
              },
              routes: getRoutesMap(injector),
            ),
          ),
        ),
      ),
    ),
  );
}

class _Bouncing extends ScrollBehavior {
  const _Bouncing();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();
}

Future<InjectorInterface> _setupEnvironment() async {
  final injector = InjectorImpl().map<MainNavigatorKeyType>(
    (i) => GlobalKey<NavigatorState>(),
    isSingleton: true,
  );
  final featureInvoker = FeatureInvoker()..use(EnvFeature(injector: injector));
  final isDebug = injector.get<EnvRegistry>().get<bool>(EnvVariables.debug);

  if (!isDebug) {
    await Executor().warmUp();
  }

  await featureInvoker.use(HttpFeature(injector: injector));

  final http = injector.get<AppHttpClientInterface>();

  featureInvoker
    ..use(AuthFeature(injector: injector, http: http))
    ..use(ProfileFeature(injector: injector, http: http))
    ..use(FeedFeature(injector: injector, http: http))
    ..use(PostFeature(injector: injector, http: http));

  return injector;
}
