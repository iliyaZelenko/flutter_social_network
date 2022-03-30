import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardFooter extends StatelessWidget {
  final PostEntity post;

  const PostCardFooter({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 20),
      child: Row(
        children: [
          const Icon(AppIcons.heart_fill, color: AppColors.red100),
          Text(post.counters.marks.toString()),
          const Padding(
            padding: EdgeInsets.only(left:20.0),
            child: Icon(AppIcons.comment_fill, color: AppColors.white40),
          ),

          Text(post.counters.comments.toString()),
          const Padding(
            padding: EdgeInsets.only(left:20.0),
            child: Icon(AppIcons.save_line, color: AppColors.white40),
          ),
          const Spacer(flex: 1),
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
