import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';

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

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 5, top: 17.5, bottom: 12.5),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _goToProfile(context, post.creator);
                },
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 50,
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
                    Row(
                      children: [
                        Text(
                          post.creator.nickname,
                          style: AppTextStyles.semiBold15.apply(color: AppColors.black100),
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
                    Text(
                      'недавно',
                      style: AppTextStyles.medium12.apply(color: AppColors.black40),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // TODO Ilya: refactor
              const Icon(
                AppIcons.round_fill,
                size: 6,
                color: AppColors.white40,
              ),
              const SizedBox(width: 3),
              const Icon(
                AppIcons.round_fill,
                size: 6,
                color: AppColors.white40,
              ),
              const SizedBox(width: 8),
            ],
          )
        ],
      ),
    );
  }
}
