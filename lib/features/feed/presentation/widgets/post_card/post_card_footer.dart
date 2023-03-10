import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/post/domain/use_cases/like_post_use_case.dart';
import 'package:rate_club/features/post/presentation/widgets/post_like.dart';
import 'package:rate_club/features/tools/number_formatter/number_formatter_interface.dart';
import 'package:rate_club/features/tools/plural/plural_interface.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/global_events/events/LikeGlobalEvent.dart';
import 'package:rate_club/resources/icons/icon_comment.dart';
import 'package:rate_club/resources/icons/icon_send.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class PostCardFooter extends StatefulWidget {
  const PostCardFooter({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCardFooter> createState() => _PostCardFooterState();
}

class _PostCardFooterState extends State<PostCardFooter> {
  late final ValueNotifier<bool> _isLiked;
  late final ValueNotifier<int> _likesCount;
  late final StreamSubscription _globalEventsSubscription;

  PostOpenByPlanEntity get _post => Provider.of<PostEntity>(context, listen: false) as PostOpenByPlanEntity;

  GlobalEventsStreamType get _globalEventsStream => Provider.of<GlobalEventsStreamType>(context, listen: false);

  InjectorInterface get _injector => Provider.of<InjectorInterface>(context, listen: false);

  LikePostUseCase get _likePostUseCase => _injector.get<LikePostUseCase>();

  @override
  void initState() {
    super.initState();

    _isLiked = ValueNotifier(_post.likedByMe);
    _likesCount = ValueNotifier(_post.likesCount);

    _globalEventsSubscription = _globalEventsStream.stream.listen((event) {
      if (event is LikeGlobalEvent && event.postId == _post.id) {
        _isLiked.value = event.likedByMe;
        _likesCount.value = event.likesCount;
      }
    });
  }

  @override
  void dispose() {
    _globalEventsSubscription.cancel();

    super.dispose();
  }

  // TODO Ilya: ?????????????? ?????????????? Broadcast streams ?? ?? ?????????? ???????????? ?????????????????? ???? ???????????? ?????????????? ?????????? (?????????? ??????????????)
  void _likePost() {
    void _setActualLikeState() {
      _globalEventsStream.add(
        LikeGlobalEvent(
          likedByMe: _post.likedByMe,
          likesCount: _post.likesCount,
          postId: _post.id,
        ),
      );
    }

    _likePostUseCase.execute(_post).catchError(
      (Object e) {
        // ???????????? ?????????????????? ??????????????
        _setActualLikeState();

        // ???????????????? ????????????, ?????????? ???????????????????????? ?? ???????? ?? ???????? ???????????? ?????? ???? ???????????? ???????? ?? ????????????.
        throw e;
      },
    );

    // ?????????? ?????????????????? ???? ???????????????????? ??????????????????
    _setActualLikeState();
  }

  @override
  Widget build(BuildContext context) {
    final plural = Provider.of<PluralInterface>(context);
    final formatter = Provider.of<NumberFormatterInterface>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Created at
              Timeago(
                builder: (_, value) => Text(
                  value,
                  style: AppTextStyles.regular13.apply(
                    color: AppColors.black60,
                  ),
                ),
                date: _post.createdAt,
              ),

              // Views
              Text(
                '${formatter.formatWithWord(_post.viewsCount)} ${plural.pluralOneMany(_post.viewsCount, 'view', 'views')}',
                style: AppTextStyles.regular13.apply(color: AppColors.black60),
              ),
            ],
          ),

          const Spacer(),

          // Share
          const IconSend(),
          const SizedBox(width: 4),
          Text(
            '20',
            style: AppTextStyles.regular13.apply(color: AppColors.black60),
          ),
          const SizedBox(width: 10),

          // Comments
          GestureDetector(
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != AppRoutes.post) {
                Navigator.of(context).pushNamed(AppRoutes.post, arguments: _post.id);
              }
            },
            child: Row(
              children: [
                const IconComment(),
                const SizedBox(width: 4),
                if (_post.commentsCount != 0)
                  Text(
                    _post.commentsCount.toString(),
                    style: AppTextStyles.regular13.apply(color: AppColors.black60),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Likes
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _likePost();
            },
            child: Row(
              children: [
                PostLike(
                  isLiked: _isLiked,
                ),
                const SizedBox(width: 4),
                ValueListenableBuilder<int>(
                  valueListenable: _likesCount,
                  builder: (ctx, count, __) {
                    return Text(
                      count.toString(),
                      style: AppTextStyles.regular13.apply(color: AppColors.black60),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
