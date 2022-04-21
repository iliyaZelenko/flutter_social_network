import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_content_closed_by_plan.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'post_card_content_carousel.dart';

class PostCardContent extends StatelessWidget {
  const PostCardContent({
    Key? key,
  }) : super(key: key);

  void _goToPost(BuildContext context, PostId id) {
    Navigator.of(context).pushNamed(AppRoutes.post, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post is PostOpenByPlanEntity) ...[
          if (post.title != null)
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.post, arguments: post.id);
                },
                child: Text(post.title!, style: AppTextStylesOld.semiBold20.apply(color: AppColors.black100)),
              ),
            ),
          // Content
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _goToPost(context, post.id);
              },
              child: ExpandableText(
                post.content,
                maxLines: 3,
                animation: true,
                style: AppTextStyles.regular13.apply(color: AppColors.black80),
                animationDuration: Durations.duration400,
                expandText: 'view all text',
                collapseText: 'hide text',
                linkColor: AppColors.black100,
                linkStyle: AppTextStyles.regular13.apply(color: AppColors.purple80),
                // WEB ссылка
                urlStyle: AppTextStyles.regular13.apply(color: AppColors.purple80),
                mentionStyle: AppTextStyles.regular13.apply(color: AppColors.purple80),
                hashtagStyle: AppTextStyles.regular13,
                onLinkTap: () {
                  _goToPost(context, post.id);
                },
                onUrlTap: launch,
              ),
            ),
          ),
          if (post.media.isNotEmpty) PostCardContentCarousel(post: post),
        ] else if (post is PostClosedByPlanEntity)
          const PostCardContentClosedByPlan()
      ],
    );
  }
}
