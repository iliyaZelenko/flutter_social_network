import 'package:flutter/cupertino.dart';
import 'package:rate_club/resources/app_colors.dart';

class PeoplePlaceScreen extends StatefulWidget {
  const PeoplePlaceScreen({Key? key}) : super(key: key);

  @override
  _PeoplePlaceScreenState createState() => _PeoplePlaceScreenState();
}

class _PeoplePlaceScreenState extends State<PeoplePlaceScreen> {
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
              Text('People Place'),
            ],
          ),
        ],
      ),
    );
  }
}
