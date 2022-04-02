import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardFooter extends StatelessWidget {
  const PostCardFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 20),
      child: Row(
        children: [
          const Icon(AppIcons.heart_fill, color: AppColors.red100),
          Text(post.counters.marks.toString()),
          const SizedBox(width: 20),
          const Icon(AppIcons.comment_fill, color: AppColors.white40),
          Text(post.counters.comments.toString()),
          const SizedBox(width: 20),
          const Icon(AppIcons.save_line, color: AppColors.white40),
          const Spacer(),
          const Icon(AppIcons.eye_line, color: AppColors.white40),
          Text(
            '${post.counters.viewed} тыс',
            style: AppTextStyles.medium12.apply(color: AppColors.black20),
          )
        ],
      ),
    );
  }
}
