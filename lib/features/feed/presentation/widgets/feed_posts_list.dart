import 'package:flutter/widgets.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';

import 'post_card/post_card.dart';

class FeedPostsList extends StatelessWidget {
  final List<PostEntity> posts;

  const FeedPostsList({
    required this.posts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) => PostCard(post: posts[index]),
        childCount: posts.length,
        addAutomaticKeepAlives: false,
        addSemanticIndexes: false,
      ),
    );
  }
}
