import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/features/subscriptions/presentation/subscriptions_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_small.dart';
import 'package:rate_club/resources/helpers.dart';
import 'package:rate_club/resources/icons/icon_menu.dart';

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

  Future<void> _subscribe(BuildContext context) async {
    final post = Provider.of<PostEntity>(context, listen: false);
    final subscriptionsPresenter = Provider.of<SubscriptionsPresenter>(context, listen: false);

    // If subscribed
    if (await subscriptionsPresenter.subscribe(context, post.creator.plans!) == true) {
      // TODO Ilya: refresh only post.
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context);
    final profilePresenter = Provider.of<ProfilePresenter>(context);
    final plansInfo = getPlansInfo(post.creator.plans!);

    final mainContent = Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
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
                    Text(
                      '@${post.creator.nickname}',
                      style: AppTextStyles.medium15.apply(
                        color: (post is PostClosedByPlanEntity) ? AppColors.white80 : AppColors.black80,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // FullName
                    Text(
                      post.creator.fullName,
                      style: AppTextStyles.regular13.apply(
                        color: (post is PostClosedByPlanEntity) ? AppColors.white40 : AppColors.black60,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // TODO Ilya
              if (post.creator.id == profilePresenter.profile!.id)
                const IconMenu()
              else
                (post is PostClosedByPlanEntity)
                    ? Text(
                        'premium content  ',
                        style: AppTextStyles.regular13.apply(
                          color: AppColors.purple80,
                        ),
                      )
                    : plansInfo.subscriptionPremiumActive == true
                        ? const SizedBox.shrink()
                        : plansInfo.subscriptionFreeActive == true
                            ? AppBtnSmall(
                                text: 'add premium',
                                color: AppColors.purple100,
                                textColor: AppColors.white80,
                                onTap: () {
                                  _subscribe(context);
                                },
                              )
                            : AppBtnSmall(
                                text: 'subscribe',
                                onTap: () {
                                  _subscribe(context);
                                },
                              ),
            ],
          )
        ],
      ),
    );

    return (post is PostClosedByPlanEntity)
        ? Padding(
            padding: const EdgeInsets.only(top: 16),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: AppColors.purple100),
              child: mainContent,
            ),
          )
        : mainContent;
  }
}
