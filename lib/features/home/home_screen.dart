import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:rate_club/features/feed/feed_screen.dart';
import 'package:rate_club/features/feed/invest_screen.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/features/home/tap_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomePresenter get homePresenter => context.presenter<HomePresenter>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: homePresenter.index,
          builder: (_, value, __) {
            return Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: value,
                    children: const [
                      FeedScreen(),
                      InvestScreen(),
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
