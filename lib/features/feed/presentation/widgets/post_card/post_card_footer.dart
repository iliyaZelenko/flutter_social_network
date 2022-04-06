import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/post/presentation/widgets/post_like.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardFooter extends StatefulWidget {
  const PostCardFooter({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCardFooter> createState() => _PostCardFooterState();
}

class _PostCardFooterState extends State<PostCardFooter> {
  ValueNotifier<bool> _isLiked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context) as PostOpenByPlanEntity;

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 20),
      child: Row(
        children: [
          // Likes
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _isLiked.value = !_isLiked.value;
            },
            child: Row(
              children: [
                PostLike(
                  isLiked: _isLiked,
                ),
                const SizedBox(width: 4),
                Text(
                  post.counters.marks.toString(),
                  style: AppTextStyles.semiBold15,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Comments
          GestureDetector(
            onTap: () {
              if (ModalRoute.of(context)!.settings.name == AppRoutes.post) {
                return;
              }

              Navigator.of(context).pushNamed(AppRoutes.post, arguments: post.id);
            },
            child: Row(
              children: [
                const Icon(
                  AppIcons.comment_fill,
                  color: AppColors.white40,
                  size: 24,
                ),
                const SizedBox(width: 4),
                Text(
                  post.counters.comments.toString(),
                  style: AppTextStyles.semiBold16.apply(color: AppColors.black60),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Bookmarks
          const Icon(
            AppIcons.bookmark_line,
            color: AppColors.white40,
            size: 24,
          ),
          const Spacer(),

          // Views
          const Icon(
            AppIcons.eye_line,
            color: AppColors.white40,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text(
            '${post.counters.viewed}',
            style: AppTextStyles.medium12.apply(color: AppColors.black20),
          )
        ],
      ),
    );
  }
}
