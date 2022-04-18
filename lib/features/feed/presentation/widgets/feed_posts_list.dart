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
    return posts.isEmpty
        ? const SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: Text('No posts'),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => PostCard(
                key: ValueKey('post${posts[index].id}'),
                post: posts[index],
              ),
              childCount: posts.length,
              addAutomaticKeepAlives: false,
              addSemanticIndexes: false,
            ),
          );
  }
}
