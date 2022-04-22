import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/presentation/feed_presenter.dart';
import 'package:rate_club/features/feed/presentation/feed_screen.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/home/presentation/widgets/tap_bar.dart';
import 'package:rate_club/features/marketplace/market_place_screen.dart';
import 'package:rate_club/features/people/people_place_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                      const MarketPlaceScreen(),
                      const PeoplePlaceScreen(),
                      MultiProvider(
                        providers: [
                          Provider<FeedPresenter>(
                            create: (_) => injector.get<FeedPresenter>(),
                          )
                        ],
                        child: const FeedScreen(),
                      ),
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
