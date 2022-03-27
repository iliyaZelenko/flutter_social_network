import 'package:app_http_client/app_http_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:rate_club/features/profile/data/repository/profile_repository_impl.dart';
import 'package:rate_club/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'features/auth/domain/use_cases/sign_in_use_case.dart';
import 'features/profile/presentation/profile_presenter.dart';
import 'resources/app_colors.dart';
import 'resources/app_routes.dart';
import 'resources/app_text_styles.dart';
import 'resources/emojis.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

const debug = kDebugMode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final mainNavigatorKey = GlobalKey<NavigatorState>();
  final injector = await _setupEnvironment(mainNavigatorKey: mainNavigatorKey);
  // final profileUseCase = dc.dependency<ProfileUseCase>(existingInstance: true);
  //
  // await profileUseCase.fetch();

  final initialRoute = AppRoutes.auth; // profileUseCase.loggedIn ? AppRoutes.home : AppRoutes.auth;

  runApp(
    MultiProvider(
      providers: [Provider<Injector>(create: (_) => injector)],
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
                    // PresenterProvider(
                    //   presenter: CorePresenter(profileUseCase),
                    //   child: widget!,
                    // ),
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

Future<Injector> _setupEnvironment({required GlobalKey<NavigatorState> mainNavigatorKey}) async {
  if (!kDebugMode) {
    await Executor().warmUp();
  }
  final http = AppHttpClient(
    log: debug,
    fakeIsolate: debug,
    defaultHost: 'https://dev.easydev.group/api/',
  );
  await http.init();

  final injector = Injector();

  // abstract class MainNavigatorKeyInterface implements GlobalKey<NavigatorState> {}
  injector.map<GlobalKey<NavigatorState>>((i) => mainNavigatorKey, isSingleton: true);
  injector.map<AppHttpClientInterface>((i) => http, isSingleton: true);

  // TODO Ilya: каждая фича сама мапит нужные зависимости в инджектор
  injector.map<AuthRepositoryImpl>(
    (i) => AuthRepositoryImpl(i.get<AppHttpClientInterface>()),
    isSingleton: true,
  );
  injector.map<SignInUseCase>(
    (i) => SignInUseCase(i.get<AuthRepositoryImpl>()),
    isSingleton: true,
  );

  injector.map<ProfileRepositoryImpl>(
    (i) => ProfileRepositoryImpl(i.get<AppHttpClientInterface>()),
    isSingleton: true,
  );
  injector.map<GetProfileUseCase>(
    (i) => GetProfileUseCase(i.get<ProfileRepositoryImpl>()),
    isSingleton: true,
  );

  injector.map<ProfilePresenter>(
    (i) => ProfilePresenter(getProfileUseCase: i.get<GetProfileUseCase>()),
    isSingleton: true,
  );

  // return DependenciesContainer(
  //   dependencies: {
  //     GlobalKey: () => mainNavigatorKey,
  //     AppHttpClientInterface: () => http,
  //     AuthUseCase: () => authUseCase(http),
  //     ProfileUseCase: () => profileUseCase(http),
  //     FeedUseCase: () => feedUseCase(http),
  //   },
  // );

  return injector;
}
