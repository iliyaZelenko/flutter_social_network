import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/chats/chats_screen.dart';
import 'package:rate_club/features/create/create_screen.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_feed_use_case.dart';
import 'package:rate_club/features/feed/feed_screen.dart';
import 'package:rate_club/features/feed/presentation/feed_presenter.dart';
import 'package:rate_club/features/invest/invest_screen.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/home/presentation/widgets/tap_bar.dart';
import 'package:rate_club/features/subscriptions/subscriptions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homePresenter = Provider.of<HomePresenter>(context);
    final injector = Provider.of<Injector>(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        Observer(
          builder: (_) {
            return Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: homePresenter.tapBarNavigationIndex,
                    children: [
                      Provider<FeedPresenter>(
                        child: const FeedScreen(),
                        create: (_) => FeedPresenter(
                          getFeedUseCase: injector.get<GetFeedUseCase>(),
                        ),
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
