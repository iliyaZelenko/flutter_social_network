import 'package:flutter/cupertino.dart';
import 'package:rate_club/resources/app_colors.dart';

class InvestScreen extends StatefulWidget {
  const InvestScreen({Key? key}) : super(key: key);

  @override
  _InvestScreenState createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> {
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
              Text('Инвест'),
            ],
          ),
        ],
      ),
    );
  }
}
