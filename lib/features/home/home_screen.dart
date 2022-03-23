import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:rate_club/features/chats/chats_screen.dart';
import 'package:rate_club/features/create/create_screen.dart';
import 'package:rate_club/features/feed/feed_presenter.dart';
import 'package:rate_club/features/feed/feed_screen.dart';
import 'package:rate_club/features/invest/invest_screen.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/features/home/tap_bar.dart';
import 'package:rate_club/features/subscriptions/subscriptions_screen.dart';

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
          builder: (_, index, __) {
            return Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: index,
                    children: [
                      PresenterProvider(
                        presenter: FeedPresenter(
                          BolterProvider.of(context).dependency<FeedUseCase>(existingInstance: true),
                        ),
                        child: const FeedScreen(),
                      ),
                      const InvestScreen(),
                      const CreateScreen(),
                      const ChatsScreen(),
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
