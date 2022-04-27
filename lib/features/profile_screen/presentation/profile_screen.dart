import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/presentation/widgets/feed_posts_list.dart';
import 'package:rate_club/features/profile_screen/presentation/widgets/profile_about.dart';
import 'package:rate_club/features/profile_screen/presentation/widgets/profile_money.dart';
import 'package:rate_club/features/profile_screen/presentation/widgets/profile_screen_header.dart';
import 'package:rate_club/features/profile_screen/presentation/widgets/profile_stats.dart';
import 'package:rate_club/features/tools/plural/plural_interface.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';
import 'package:rate_club/resources/header/header.dart';
import 'package:rate_club/resources/header/slots_content/profile_in_header.dart';
import 'package:rate_club/resources/icons/icon_arrow_left.dart';
import 'package:rate_club/resources/icons/icon_filter.dart';

import 'abstract_profile_screen_presenter.dart';

class ProfileScreen extends StatefulWidget {
  final MainNavigatorKeyType _mainNavigatorKey;

  const ProfileScreen({
    Key? key,
    required MainNavigatorKeyType mainNavigatorKey,
  })  : _mainNavigatorKey = mainNavigatorKey,
        super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AfterLayoutMixin {
  AbstractProfileScreenPresenter get presenter => Provider.of<AbstractProfileScreenPresenter>(context, listen: false);

  @override
  void afterFirstLayout(BuildContext context) {
    presenter.fetch();
    presenter.fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Content
            Positioned.fill(
              top: Header.height,
              child: Observer(
                builder: (_) {
                  return presenter.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const _ProfileBody();
                },
              ),
            ),

            // Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Header(
                slot: GestureDetector(
                  onTap: () {
                    // TODO Ilya: use Provider, really
                    widget._mainNavigatorKey.currentState!.pop();
                  },
                  child: Observer(builder: (_) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const IconArrowLeft(
                          size: 32,
                          color: AppColors.black80,
                        ),
                        Expanded(
                          child: Text(
                            // TODO Ilya: Save to storage before go to profile?
                            presenter.profile == null ? '' : presenter.profile!.fullName,
                            style: AppTextStyles.medium15.apply(color: AppColors.black80),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        const ProfileInHeader(),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<AbstractProfileScreenPresenter>(context);
    final plural = Provider.of<PluralInterface>(context);

    return Observer(
      builder: (_) {
        if (presenter.profile == null) return const SizedBox.shrink();

        return Refreshable(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          onRefresh: presenter.refresh,
          slivers: [
            const SliverToBoxAdapter(
              child: ProfileScreenHeader(),
            ),
            Observer(
              builder: (_) {
                return presenter.currentTab == 0 && presenter.posts != null
                    ? SliverPadding(
                        padding: const EdgeInsets.only(top: 24, bottom: 8, left: 10, right: 10),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Text(
                                '${presenter.postsCount} ${plural.pluralOneMany(
                                  presenter.postsCount!,
                                  'post',
                                  'posts',
                                )}',
                              ),
                              const Spacer(),
                              const IconFilter(),
                            ],
                          ),
                        ),
                      )
                    : const SliverToBoxAdapter(child: nil);
              },
            ),
            Observer(
              builder: (_) {
                // TODO Ilya: refactor
                return [
                  if (presenter.posts == null)
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    FeedPostsList(posts: presenter.posts!),
                  const SliverToBoxAdapter(child: ProfileStats()),
                  const SliverToBoxAdapter(child: ProfileMoney()),
                  const SliverToBoxAdapter(child: ProfileAbout()),
                ][presenter.currentTab];
              },
            ),
          ],
        );
      },
    );
  }
}
