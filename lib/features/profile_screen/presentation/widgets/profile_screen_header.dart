import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/buttons/regular_app_btn.dart';

import '../abstract_profile_screen_presenter.dart';

class ProfileScreenHeader extends StatelessWidget {
  const ProfileScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AbstractProfileScreenPresenter>(context);
    final profile = presenter.profile!;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.white100,
          border: Border(
            top: BorderSide(width: 0.7, color: AppColors.white60),
            bottom: BorderSide(width: 0.7, color: AppColors.white60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
              child: Row(
                children: [
                  // Avatar
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profile.avatar),
                    ),
                  ),
                  const SizedBox(width: 21),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Username
                        Row(
                          children: [
                            Text(
                              profile.username,
                              style: AppTextStyles.semiBold20.apply(color: AppColors.black100),
                            ),
                            // Verified
                            if (presenter.profile!.isVerified) ...const [
                              SizedBox(width: 9),
                              Icon(
                                AppIcons.check_circle_fill,
                                size: 24,
                              )
                            ]
                          ],
                        ),
                        const SizedBox(height: 5),
                        // About
                        if (profile.about != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  profile.about!,
                                  style: AppTextStyles.medium14.apply(color: AppColors.black60),
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
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 8, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      // TODO Ilya: iterate (counters)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '11,5 млн ',
                            style: AppTextStyles.medium15.apply(color: AppColors.black100),
                          ),
                          Text(
                            'подписчиков',
                            style: AppTextStyles.regular15.apply(color: AppColors.black80),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '42 ',
                            style: AppTextStyles.medium15.apply(color: AppColors.black100),
                          ),
                          Text(
                            'публицкации',
                            style: AppTextStyles.regular15.apply(color: AppColors.black80),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '105 ',
                            style: AppTextStyles.medium15.apply(color: AppColors.black100),
                          ),
                          Text(
                            'подписок',
                            style: AppTextStyles.regular15.apply(color: AppColors.black80),
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '22 ',
                            style: AppTextStyles.medium15.apply(color: AppColors.black100),
                          ),
                          Text(
                            'токена',
                            style: AppTextStyles.regular15.apply(color: AppColors.black80),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 33),
                  const Center(
                    child: RegularAppBtn(
                      text: 'подписаться',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
