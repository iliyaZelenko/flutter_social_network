import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/buttons/regular_app_btn.dart';

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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.post, arguments: post.id);
                },
                child: Text(post.title!, style: AppTextStyles.semiBold20.apply(color: AppColors.black100)),
              ),
            ),
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(236, 240, 255, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    child: Column(
                      children: [
                        Text(
                          'Автор сделал этот контент доступным только для подписки:',
                          style: AppTextStyles.medium12.apply(color: AppColors.black100),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          post.needBuyPlan.title,
                          style: AppTextStyles.semiBold16.apply(color: AppColors.purple80),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'и выше',
                          style: AppTextStyles.medium12.apply(color: AppColors.black80),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const RegularAppBtn(
                text: 'подписаться',
                useMinPadding: true,
              ),
              const SizedBox(height: 20),
            ],
          )
      ],
    );
  }
}
