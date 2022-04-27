import 'package:flutter/cupertino.dart';
import 'package:rate_club/resources/app_colors.dart';

class HR extends StatelessWidget {
  const HR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(color: AppColors.white40),
      ),
    );
  }
}
