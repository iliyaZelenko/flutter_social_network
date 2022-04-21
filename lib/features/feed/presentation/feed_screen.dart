import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/assets.dart';
import 'package:rate_club/resources/common_widgets/app_drawer.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';
import 'package:rate_club/resources/header.dart';
import 'package:rate_club/resources/icons/icon_add.dart';

import 'feed_presenter.dart';
import 'widgets/feed_posts_list.dart';

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
    final profilePresenter = Provider.of<ProfilePresenter>(context);
    final drawerController = Provider.of<AppDrawerController>(context);

    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: Header.height,
              left: 0,
              right: 0,
              bottom: 0,
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Header(
                slot: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.logo,
                        width: 32,
                        height: 25,
                      ),

                      const Spacer(),
                      const IconAdd(
                        size: 32,
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'create new',
                        style: AppTextStyles.medium15.apply(color: AppColors.black80),
                      ),
                      const Spacer(),

                      // Avatar with the bell indicator
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              drawerController.open();
                            },
                            child: SizedBox(
                              width: 32,
                              height: 32,
                              child: CircleAvatar(
                                radius: 200,
                                backgroundImage: NetworkImage(profilePresenter.profile!.avatar),
                              ),
                            ),
                          ),
                          // Red dot
                          Positioned(
                            top: -5,
                            right: -5,
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 109, 28, 1),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.white100, width: 2)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              sliver: FeedPostsList(posts: posts),
            ),
          ],
        );
      },
    );
  }
}
