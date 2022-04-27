import 'package:flutter/cupertino.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white100,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Text(
            '''
Channel creation date: 05/12/2021\n
Views: 253 240 500\n
Subscribers: 11 542 231\n
NFT tokens: 25''',
            style: AppTextStyles.regular13,
          ),
        ),
      ),
    );
  }
}
