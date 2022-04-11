import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/create/create_screen.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_feed_use_case.dart';
import 'package:rate_club/features/feed/presentation/feed_presenter.dart';
import 'package:rate_club/features/feed/presentation/feed_screen.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/home/presentation/widgets/tap_bar.dart';
import 'package:rate_club/features/subscriptions/subscriptions_screen.dart';
import 'package:rate_club/resources/common_widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _drawerController = AppDrawerController();

  @override
  Widget build(BuildContext context) {
    final homePresenter = Provider.of<HomePresenter>(context);
    final injector = Provider.of<InjectorInterface>(context);

    return Stack(
      children: [
        Observer(
          builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: homePresenter.tapBarNavigationIndex,
                    children: [
                      MultiProvider(
                        providers: [
                          Provider<FeedPresenter>(
                            create: (_) => FeedPresenter(
                              getFeedUseCase: injector.get<GetFeedUseCase>(),
                            ),
                          )
                        ],
                        child: const FeedScreen(),
                      ),
                      const CreateScreen(),
                      const SubscriptionsScreen(),
                    ],
                  ),
                ),
                const TapBar(),
              ],
            );
          },
        ),
      ],
    );
  }
}
