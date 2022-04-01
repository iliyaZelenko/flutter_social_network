import 'package:app_http_client/app_http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injector/injector.dart';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/feed_feature.dart';
import 'package:rate_club/features/http/http_feature.dart';
import 'package:rate_club/features/profile/profile_feature.dart';
import 'package:rate_club/rate_club.dart';

import 'features/auth/auth_feature.dart';
import 'features/feature_invoker.dart';
import 'features/profile/presentation/profile_presenter.dart';
import 'resources/app_colors.dart';
import 'resources/app_routes.dart';
import 'resources/app_text_styles.dart';
import 'resources/emojis.dart';

const debug = kDebugMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final MainNavigatorKeyType mainNavigatorKey = GlobalKey<NavigatorState>();
  final injector = await _setupEnvironment(mainNavigatorKey: mainNavigatorKey);
  final profilePresenter = injector.get<ProfilePresenter>();

  await injector.get<ProfilePresenter>().fetch();

  // TODO Ilya: loggedIn ответстввенность на стороне AuthPresenter'а (отделённого от AuthFlowPresenter).
  final initialRoute = profilePresenter.profile == null ? AppRoutes.auth : AppRoutes.home;

  runApp(
    MultiProvider(
      providers: [
        Provider<InjectorInterface>(create: (_) => injector),
        Provider<ProfilePresenter>(create: (_) => injector.get<ProfilePresenter>()),
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
              navigatorKey: mainNavigatorKey,
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

Future<InjectorInterface> _setupEnvironment({required MainNavigatorKeyType mainNavigatorKey}) async {
  if (!kDebugMode) {
    await Executor().warmUp();
  }

  final injector = InjectorImpl()..map<MainNavigatorKeyType>((i) => mainNavigatorKey, isSingleton: true);
  final featureInvoker = FeatureInvoker();

  await featureInvoker.use(HttpFeature(injector: injector));

  final http = injector.get<AppHttpClientInterface>();

  featureInvoker
    ..use(AuthFeature(injector: injector, http: http))
    ..use(ProfileFeature(injector: injector, http: http))
    ..use(FeedFeature(injector: injector, http: http));

  return injector;
}
