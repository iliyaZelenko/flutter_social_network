import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class PostScreenHeader extends StatelessWidget {
  const PostScreenHeader({
    Key? key,
  }) : super(key: key);

  void _goToProfile(BuildContext context, PostCreatorEntity profile) {
    Navigator.of(context).pushNamed(
      AppRoutes.otherProfile,
      arguments: Provider.of<PostPresenter>(context, listen: false).post!.creator.nickname,
    );
  }

  @override
  Widget build(BuildContext context) {
    final postPresenter = Provider.of<PostPresenter>(context);
    final post = postPresenter.post! as PostOpenByPlanEntity;

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
                    Timeago(
                      builder: (_, value) => Text(
                        value,
                        style: AppTextStyles.medium12.apply(color: AppColors.black40),
                      ),
                      date: post.createdAt,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
