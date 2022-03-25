import 'package:feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/feed/widgets/post_card/post_card_content_carousel.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardContent extends StatelessWidget {
  final PostEntity post;

  const PostCardContent({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(post.content),
        ),
        if (post.media.isNotEmpty)
          PostCardContentCarousel(post: post),
      ],
    );
  }
}
