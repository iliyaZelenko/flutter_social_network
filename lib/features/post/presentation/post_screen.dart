import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/presentation/widgets/post_card/post_card_footer.dart';
import 'package:rate_club/features/post/presentation/widgets/post_screen_content.dart';
import 'package:rate_club/features/post/presentation/widgets/post_screen_header.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';
import 'package:rate_club/resources/header.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        child: Column(
          children: [
            Header(
              slot: GestureDetector(
                onTap: () {
                  // TODO Ilya: use Provider, really
                  widget._mainNavigatorKey.currentState!.pop();
                },
                child: Row(
                  children: [
                    const Icon(AppIcons.arrow_left_line, color: AppColors.black100),
                    const SizedBox(width: 15),
                    Text(
                      'Публикация',
                      style: AppTextStyles.semiBold16.apply(color: AppColors.black100),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
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
          ],
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.white100,
                    border: Border(
                      top: BorderSide(width: 0.7, color: AppColors.white60),
                      bottom: BorderSide(width: 0.7, color: AppColors.white60),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PostScreenHeader(),
                      const PostScreenContent(),
                      Provider<PostEntity>(
                        create: (_) => postPresenter.post!,
                        child: const PostCardFooter(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
