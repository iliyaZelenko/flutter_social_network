import 'package:app_http_client/app_http_client.dart';
import 'package:auth/auth.dart';
import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:nil/nil.dart';
import 'package:profile/profile.dart';
import 'features/core/core_presenter.dart';
import 'resources/app_colors.dart';
import 'resources/app_routes.dart';
import 'resources/app_text_styles.dart';
import 'resources/emojis.dart';

const debug = kDebugMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final mainNavigatorKey = GlobalKey<NavigatorState>();
  final dc = await _setupEnvironment(mainNavigatorKey: mainNavigatorKey);
  final profileUseCase = dc.dependency<ProfileUseCase>(existingInstance: true);

  await profileUseCase.fetch();

  final initialRoute = profileUseCase.loggedIn ? AppRoutes.home : AppRoutes.auth;

  runApp(
    BolterProvider(
      container: dc,
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
                    PresenterProvider(
                      presenter: CorePresenter(profileUseCase),
                      child: widget!,
                    ),
                  ],
                );
              },
              routes: getRoutesMap(dc),
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

Future<DependenciesContainer> _setupEnvironment({ required GlobalKey mainNavigatorKey }) async {
  if (!kDebugMode) {
    await Executor().warmUp();
  }
  final http = AppHttpClient(
    log: debug,
    fakeIsolate: debug,
    defaultHost: 'https://dev.easydev.group/api/',
  );
  await http.init();

  return DependenciesContainer(
    dependencies: {
      GlobalKey: () => mainNavigatorKey,
      AppHttpClientInterface: () => http,
      AuthUseCase: () => authUseCase(http),
      ProfileUseCase: () => profileUseCase(http),
      FeedUseCase: () => feedUseCase(http),
    },
  );
}
