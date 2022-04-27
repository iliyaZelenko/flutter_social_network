import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AbstractProfileScreenPresenter>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.white100,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              const Text(
                'Description',
                style: AppTextStyles.medium15,
              ),
              const SizedBox(height: 4),
              Text(
                presenter.profile!.about ?? 'No description',
                style: AppTextStyles.regular13,
              ),
              const SizedBox(height: 16),

              // Links
              const Text(
                'Links',
                style: AppTextStyles.medium15,
              ),
              const SizedBox(height: 4),
              Text(
                'support the channel',
                style: AppTextStyles.regular13.apply(color: AppColors.blue100),
              ),
              const SizedBox(height: 4),
              Text(
                'my personal course “Map of Wishes”',
                style: AppTextStyles.regular13.apply(color: AppColors.blue100),
              ),
              const SizedBox(height: 4),
              Text(
                'something else',
                style: AppTextStyles.regular13.apply(color: AppColors.blue100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
