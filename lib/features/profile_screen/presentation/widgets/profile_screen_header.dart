import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/tools/number_formatter/number_formatter_interface.dart';
import 'package:rate_club/features/tools/plural/plural_interface.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_regular.dart';
import 'package:rate_club/resources/common_widgets/hr.dart';
import 'package:rate_club/resources/icons/icon_social_facebook.dart';
import 'package:rate_club/resources/icons/icon_social_instagram.dart';
import 'package:rate_club/resources/icons/icon_social_twitter.dart';
import 'package:rate_club/resources/icons/icon_social_you_tube.dart';

import '../abstract_profile_screen_presenter.dart';
import 'profile_tabs.dart';

class _CounterData {
  final int count;
  final String one;
  final String many;

  _CounterData(this.count, this.one, this.many);
}

class ProfileScreenHeader extends StatelessWidget {
  const ProfileScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plural = Provider.of<PluralInterface>(context);
    final formatter = Provider.of<NumberFormatterInterface>(context);
    final presenter = Provider.of<AbstractProfileScreenPresenter>(context);
    final profile = presenter.profile!;
    final List<_CounterData> countersToDisplay = [
      _CounterData(profile.counters.subscribers, 'subscriber', 'subscribers'),
      _CounterData(profile.counters.contracts, 'subscribe', 'subscribes'),
      _CounterData(profile.counters.tokens, 'token', 'tokens'),
    ];

    return DecoratedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  // Avatar
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: CircleAvatar(
                      radius: 200,
                      backgroundImage: NetworkImage(profile.avatar),
                    ),
                  ),
                  const SizedBox(width: 21),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nickname
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '@${profile.nickname}',
                                style: AppTextStyles.medium20.apply(color: AppColors.black80),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        // About
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                profile.fullName,
                                style: AppTextStyles.regular15.apply(color: AppColors.black60),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            const AppBtnRegular(
              text: 'subscribe',
              color: AppColors.blue60,
              textColor: AppColors.black80,
            ),
            const SizedBox(height: 16),

            const HR(),
            const SizedBox(height: 16),

            // Counters
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      ...countersToDisplay.map(
                        (counter) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${formatter.formatWithWord(counter.count)} ',
                              style: AppTextStyles.regular13.apply(color: AppColors.black100),
                            ),
                            Text(
                              plural.pluralOneMany(
                                counter.count,
                                counter.one,
                                counter.many,
                              ),
                              style: AppTextStyles.regular13.apply(color: AppColors.black80),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Center(
              child: Wrap(
                spacing: 20,
                children: const [
                  IconSocialYouTube(),
                  IconSocialFacebook(),
                  IconSocialTwitter(),
                  IconSocialInstagram(),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const HR(),
            const SizedBox(height: 16),

            const ProfileTabs(),
          ],
        ),
      ),
    );
  }
}
