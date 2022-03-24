import 'package:feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/feed/widgets/post_card/post_card_content.dart';
import 'package:rate_club/features/feed/widgets/post_card/post_card_footer.dart';
import 'package:rate_club/features/feed/widgets/post_card/post_card_header.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;

  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.white100,
          border: Border(
            top: BorderSide(width: 0.7, color: AppColors.white60),
            bottom: BorderSide(width: 0.7, color: AppColors.white60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostCardHeader(post: post),
            PostCardContent(post: post),
            PostCardFooter(post: post),
          ],
        )// Text(post.content),
      ),
    );
  }
}
