import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolated_http_client/isolated_http_client.dart';
import 'package:nil/nil.dart';
import 'features/home/home_presenter.dart';
import 'features/core/core_presenter.dart';
import 'resources/app_colors.dart';
import 'resources/app_routes.dart';
import 'resources/app_text_styles.dart';
import 'resources/emojis.dart';
import 'features/home/home_screen.dart';

final mainNavigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  if (!kDebugMode) {
    await Executor().warmUp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BolterProvider(
      container: DependenciesContainer(),
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
                  textStyle: TextStyle(color: AppColors.black80)
                ),
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [DefaultMaterialLocalizations.delegate],
              initialRoute: AppRoutes.home,
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
                      presenter: CorePresenter(),
                      child: widget!,
                    ),
                  ],
                );
              },
              routes: {
                AppRoutes.home: (_) {
                  return PresenterProvider(
                    presenter: HomePresenter(),
                    child: const HomeScreen(),
                  );
                },
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Bouncing extends ScrollBehavior {
  const _Bouncing();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();
}
