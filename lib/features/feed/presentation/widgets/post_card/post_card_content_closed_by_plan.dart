import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/buttons/app_btn_regular.dart';

class PostCardContentClosedByPlan extends StatelessWidget {
  const PostCardContentClosedByPlan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context) as PostClosedByPlanEntity;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 32, bottom: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'post is available\nonly for ${post.needBuyPlan.title} subscribers',
                    style: AppTextStyles.regular18.apply(color: AppColors.black80),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: AppBtnRegular(
                  text: 'go to ${post.needBuyPlan.title} subscribe',
                  color: AppColors.purple100,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
