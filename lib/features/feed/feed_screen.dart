import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:rate_club/features/home/header.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  HomePresenter get homePresenter => context.presenter<HomePresenter>();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Лента'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
