import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_content_carousel.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';

class PostScreenContent extends StatelessWidget {
  const PostScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postPresenter = Provider.of<PostPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(postPresenter.post!.content),
        ),
        if (postPresenter.post!.media.isNotEmpty) PostCardContentCarousel(post: postPresenter.post!),
      ],
    );
  }
}
