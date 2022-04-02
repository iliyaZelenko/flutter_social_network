import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/home/presentation/widgets/header.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';

import 'presentation/feed_presenter.dart';
import 'presentation/widgets/post_card/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with AfterLayoutMixin {
  FeedPresenter get feedPresenter => Provider.of<FeedPresenter>(context, listen: false);

  @override
  void afterFirstLayout(BuildContext context) {
    feedPresenter.initFetch();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: Observer(
                builder: (_) {
                  return feedPresenter.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const _FeedBody();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedBody extends StatelessWidget {
  const _FeedBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedPresenter = Provider.of<FeedPresenter>(context);

    return Observer(
      builder: (_) {
        if (feedPresenter.feed == null) return const SizedBox.shrink();

        final posts = feedPresenter.feed!.results;

        return Refreshable(
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            onRefresh: feedPresenter.refresh,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) => PostCard(post: posts[index]),
                  childCount: posts.length,
                  addAutomaticKeepAlives: false,
                  addSemanticIndexes: false,
                ),
              )
            ]);
      },
    );
  }
}
