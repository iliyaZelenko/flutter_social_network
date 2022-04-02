import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/home/presentation/widgets/header.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';

import 'presentation/post_presenter.dart';

class PostScreen extends StatefulWidget {
  final PostId _postId;

  const PostScreen({
    Key? key,
    required PostId postId,
  })  : _postId = postId,
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
            const Header(),
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
              child: Text(postPresenter.post!.content),
            )
          ],
        );
      },
    );
  }
}
