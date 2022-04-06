import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_content_closed_by_plan.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';

import 'post_card_content_carousel.dart';

class PostCardContent extends StatelessWidget {
  const PostCardContent({
    Key? key,
  }) : super(key: key);

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
                child: Text(post.title!, style: AppTextStyles.semiBold20.apply(color: AppColors.black100)),
              ),
            ),
          // Content
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.post, arguments: post.id);
              },
              child: Text(post.content, style: AppTextStyles.regular15.apply(color: AppColors.black100)),
            ),
          ),
          if (post.media.isNotEmpty) PostCardContentCarousel(post: post),
        ] else if (post is PostClosedByPlanEntity)
          const PostCardContentClosedByPlan()
      ],
    );
  }
}
