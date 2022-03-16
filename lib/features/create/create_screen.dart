import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  HomePresenter get homePresenter => context.presenter<HomePresenter>();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Создать'),
            ],
          ),
        ],
      ),
    );
  }
}
