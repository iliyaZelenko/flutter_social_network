import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/post/domain/use_cases/like_post_use_case.dart';
import 'package:rate_club/features/post/presentation/widgets/post_like.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/global_events/events/LikeGlobalEvent.dart';
import 'package:rate_club/resources/icons/icon_comment.dart';
import 'package:rate_club/resources/icons/icon_send.dart';
import 'package:rate_club/resources/icons/icon_show.dart';

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

  // TODO Ilya: слушать событие Broadcast streams и в ленте менять состояние на основе событий лайка (класс события)
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
        // Ставит состояние обратно
        _setActualLikeState();

        // Передаем дальше, чтобы обработалось в зоне и юзер увидел что за ошибка была с лайком.
        throw e;
      },
    );

    // Сразу реагирует на изменённое состояние
    _setActualLikeState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
      child: Row(
        children: [
          // Views
          const IconShow(),
          const SizedBox(width: 4),
          Text(
            '${_post.viewsCount}',
            style: AppTextStyles.regular13.apply(color: AppColors.black60),
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
