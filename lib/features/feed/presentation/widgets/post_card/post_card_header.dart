import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/icons/icon_menu.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({
    Key? key,
  }) : super(key: key);

  void _goToProfile(BuildContext context, PostCreatorEntity profile) {
    final notProfileScreen = Provider.of<AbstractProfileScreenPresenter?>(context, listen: false) == null;

    if (notProfileScreen) {
      Navigator.of(context).pushNamed(AppRoutes.otherProfile, arguments: profile.nickname);
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context);
    final profilePresenter = Provider.of<ProfilePresenter>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 17.5, bottom: 12.5),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _goToProfile(context, post.creator);
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    radius: 200,
                    backgroundImage: NetworkImage(post.creator.avatar),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _goToProfile(context, post.creator);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nickname
                    Row(
                      children: [
                        Text(
                          '@${post.creator.nickname}',
                          style: AppTextStyles.medium15.apply(color: AppColors.black80),
                        ),
                        if (post.creator.isVerified) ...const [
                          SizedBox(width: 5),
                          Icon(
                            AppIcons.check_circle_fill,
                            size: 17,
                          )
                        ]
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Created at
                    if (post is PostOpenByPlanEntity)
                      Timeago(
                        builder: (_, value) => Text(
                          value,
                          style: AppTextStyles.regular13.apply(color: AppColors.black60),
                        ),
                        date: post.createdAt,
                      ),
                  ],
                ),
              ),
              const Spacer(),

              // TODO Ilya
              if (post.creator == profilePresenter.profile) const IconMenu() else const Text('subscribe'),
            ],
          )
        ],
      ),
    );
  }
}
