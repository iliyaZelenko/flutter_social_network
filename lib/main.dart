import 'dart:async';
import 'dart:io' as io;

import 'package:app_http_client/app_http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injector/injector.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/env/env_feature.dart';
import 'package:rate_club/features/env/env_registry.dart';
import 'package:rate_club/features/env/env_variables.dart';
import 'package:rate_club/features/feed/feed_feature.dart';
import 'package:rate_club/features/http/http_feature.dart';
import 'package:rate_club/features/payments/money_formatter/money_formatter_interface.dart';
import 'package:rate_club/features/post/post_feature.dart';
import 'package:rate_club/features/profile/profile_feature.dart';
import 'package:rate_club/features/profile_screen/profile_screen_feature.dart';
import 'package:rate_club/features/tools/number_formatter/number_formatter_interface.dart';
import 'package:rate_club/features/tools/tools_feature.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/media_query_setup.dart';
import 'package:worker_manager/worker_manager.dart';

import 'features/auth/auth_feature.dart';
import 'features/feature_invoker.dart';
import 'features/home/home_feature.dart';
import 'features/home/presentation/home_presenter.dart';
import 'features/payments/payments_feature.dart';
import 'features/profile/presentation/profile_presenter.dart';
import 'features/subscriptions/subscriptions_feature.dart';
import 'features/tools/plural/plural_interface.dart';
import 'resources/app_colors.dart';
import 'resources/app_routes.dart';
import 'resources/app_text_styles.dart';
import 'resources/common_widgets/app_drawer.dart';
import 'resources/errors_handler.dart';

late final _mainNavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await runZonedGuarded(() async {
    await _runRateClub();
  }, (error, stackTrace) {
    if (error is AppHttp401Exception) {
      _mainNavigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.auth, (route) => false);
    } else if (error is! CanceledError) {
      // TODO Ilya: show notification
      showErrorMsg(error, _mainNavigatorKey);

      if (kDebugMode) {
        debugPrint('ERROR: $error');

        throw error;
      } else {
        // FirebaseCrashlytics.instance.recordError(error, st);
      }
    }
  });
}

Future<void> _runRateClub() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: AppColors.white100, // Color for Android
  //     statusBarBrightness: Brightness.dark, // Dark == white status bar -- for IOS.
  //   ),
  // );
  _fixCertificateError();

  final injector = await _setupEnvironment();
  final navigatorKey = injector.get<MainNavigatorKeyType>();
  final authPresenter = injector.get<AuthPresenter>();

  await authPresenter.fetchCurrentUser();

  final initialRoute = authPresenter.loggedIn ? AppRoutes.home : AppRoutes.auth;

  runApp(
    MultiProvider(
      providers: [
        Provider<InjectorInterface>(create: (_) => injector),
        Provider<PluralInterface>(create: (_) => injector.get<PluralInterface>()),
        Provider<NumberFormatterInterface>(create: (_) => injector.get<NumberFormatterInterface>()),
        Provider<MoneyFormatterInterface>(create: (_) => injector.get<MoneyFormatterInterface>()),
        Provider<HomePresenter>(create: (_) => injector.get<HomePresenter>()),
        Provider<ProfilePresenter>(create: (_) => injector.get<ProfilePresenter>()),
        Provider<AuthPresenter>(create: (_) => injector.get<AuthPresenter>()),
        Provider<AppDrawerController>(
          create: (_) => AppDrawerController(),
        ),
        Provider<GlobalEventsStreamType>(
          create: (_) => StreamController.broadcast(),
        ),
        Provider<MainNavigatorKeyType>(
          create: (_) => navigatorKey,
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
                    navLargeTitleTextStyle: AppTextStylesOld.semiBold16,
                    primaryColor: AppColors.black80,
                    textStyle: TextStyle(color: AppColors.black80)),
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
              initialRoute: initialRoute,
              home: nil,
              builder: (ctx, widget) {
                return MediaQuerySetup(
                  Stack(
                    children: [
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
                  ),
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
    (i) => _mainNavigatorKey,
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
    ..use(ToolsFeature(injector: injector))
    ..use(AuthFeature(injector: injector, http: http))
    ..use(SubscriptionsFeature(injector: injector, http: http))
    ..use(HomeFeature(injector: injector))
    ..use(ProfileFeature(injector: injector, http: http))
    ..use(ProfileScreenFeature(injector: injector, http: http))
    ..use(FeedFeature(injector: injector, http: http))
    ..use(PostFeature(injector: injector, http: http))
    ..use(PaymentsFeature(injector: injector));

  return injector;
}

void _fixCertificateError() {
  io.HttpOverrides.global = _MyHttpOverrides();
}

// TODO Ilya: use real certificate https://stackoverflow.com/a/69481863/5286034
class _MyHttpOverrides extends io.HttpOverrides {
  @override
  io.HttpClient createHttpClient(io.SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (io.X509Certificate cert, String host, int port) => true;
  }
}
