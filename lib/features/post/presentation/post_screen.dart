import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_content_closed_by_plan.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_footer.dart';
import 'package:rate_club/features/post/presentation/widgets/post_screen_content.dart';
import 'package:rate_club/features/post/presentation/widgets/post_screen_header.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';
import 'package:rate_club/resources/header/header.dart';
import 'package:rate_club/resources/header/slots_content/profile_in_header.dart';
import 'package:rate_club/resources/icons/icon_arrow_left.dart';

import 'post_presenter.dart';

class PostScreen extends StatefulWidget {
  final PostId _postId;
  final MainNavigatorKeyType _mainNavigatorKey;

  const PostScreen({
    Key? key,
    required PostId postId,
    required MainNavigatorKeyType mainNavigatorKey,
  })  : _postId = postId,
        _mainNavigatorKey = mainNavigatorKey,
        super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> with AfterLayoutMixin {
  PostPresenter get postPresenter => Provider.of<PostPresenter>(context, listen: false);

  @override
  void afterFirstLayout(BuildContext context) {
    postPresenter.initFetch(widget._postId);
    postPresenter.fetchComments(widget._postId);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.white100, // Color for Android
        statusBarBrightness: Brightness.dark, // Dark == white status bar -- for IOS.
      ),
      child: ColoredBox(
        color: AppColors.white80,
        child: SafeArea(
          bottom: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                top: Header.height,
                child: Observer(
                  builder: (_) {
                    return postPresenter.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const _PostBody();
                  },
                ),
              ),
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
                    child: Row(
                      children: [
                        const IconArrowLeft(),
                        const Spacer(),
                        Text(
                          'post',
                          style: AppTextStyles.medium15.apply(color: AppColors.black80),
                        ),
                        const Spacer(),
                        const ProfileInHeader(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostBody extends StatelessWidget {
  const _PostBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postPresenter = Provider.of<PostPresenter>(context);

    return Observer(
      builder: (_) {
        if (postPresenter.post == null) return const SizedBox.shrink();

        return Refreshable(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          onRefresh: postPresenter.refresh,
          slivers: [
            SliverFillRemaining(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.white100,
                  border: Border(
                    bottom: BorderSide(width: 0.7, color: AppColors.white60),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: postPresenter.post! is PostClosedByPlanEntity
                      // Если контент поста не допступен по плану
                      ? [const PostCardContentClosedByPlan()]
                      : [
                          // Header
                          Provider<PostEntity>(
                            create: (_) => postPresenter.post!,
                            child: const PostScreenHeader(),
                          ),

                          // Content
                          const PostScreenContent(),

                          // Footer
                          DecoratedBox(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColors.white40),
                              ),
                            ),
                            child: Provider<PostEntity>(
                              create: (_) => postPresenter.post!,
                              child: const PostCardFooter(),
                            ),
                          ),

                          // Comments
                          if (postPresenter.postCommentsResponse == null)
                            const Expanded(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else
                            Expanded(
                              child: ListView.builder(
                                addAutomaticKeepAlives: false,
                                addRepaintBoundaries: false,
                                addSemanticIndexes: false,
                                itemExtent: 60,
                                padding: const EdgeInsets.only(top: 20, left: 14, right: 14, bottom: 50),
                                itemBuilder: (ctx, index) {
                                  final comment = postPresenter.postCommentsResponse!.results.elementAt(index);
                                  return Text(comment.content);
                                },
                                itemCount: postPresenter.postCommentsResponse!.results.length,
                              ),
                            ),
                        ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
