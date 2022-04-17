import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_content_carousel.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostScreenContent extends StatelessWidget {
  const PostScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postPresenter = Provider.of<PostPresenter>(context);
    final post = postPresenter.post! as PostOpenByPlanEntity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.title != null)
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Text(post.title!, style: AppTextStyles.semiBold20.apply(color: AppColors.black100)),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(post.content, style: AppTextStyles.regular15.apply(color: AppColors.black100)),
        ),
        if (post.media.isNotEmpty) PostCardContentCarousel(post: post),
      ],
    );
  }
}
