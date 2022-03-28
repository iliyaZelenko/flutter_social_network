import 'package:flutter/widgets.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';

import 'post_card_content_carousel.dart';

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
