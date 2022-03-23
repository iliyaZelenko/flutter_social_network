import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/feed/feed_presenter.dart';
import 'package:rate_club/features/home/header.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final feedPresenter = context.presenter<FeedPresenter>();

    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        child: Column(
          children: [
            const Header(),
            ValueListenableBuilder<bool>(
              valueListenable: feedPresenter.loading,
              builder: (ctx, loading, _) {
                return loading ? const CircularProgressIndicator() : const _FeedBody();
              },
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
    final presenter = context.presenter<FeedPresenter>();

    return ValueStreamBuilder<FeedResponseEntity?>(
      valueStream: presenter.feed,
      builder: (context, feed) {
        if (feed == null) return const SizedBox.shrink();

        final posts = feed.results;

        return Expanded(
          child: Refreshable(
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            onRefresh: presenter.refresh,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                    final currentPost = posts[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(currentPost.content),
                      ),
                    );
                  },
                  childCount: posts.length,
                  addAutomaticKeepAlives: false,
                  addSemanticIndexes: false,
                ),
              )
            ],
            refreshIndicatorExtent: 100,
            refreshTriggerPullDistance: 140,
          ),
        );
      },
    );
  }
}
