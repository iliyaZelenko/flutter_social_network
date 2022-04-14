import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/presentation/feed_presenter.dart';
import 'package:rate_club/features/post/presentation/widgets/post_like.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';

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

  PostOpenByPlanEntity get _post => Provider.of<PostEntity>(context, listen: false) as PostOpenByPlanEntity;

  // TODO Ilya: Это может быть и пост. Добавить абстракцию чтобы работало универсально. Что-то типа LikeablePost
  FeedPresenter get _feedPresenter => Provider.of<FeedPresenter>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _isLiked = ValueNotifier(_post.likedByMe);
    _likesCount = ValueNotifier(_post.marksCount);
  }

  void _setActualLikeState() {
    _isLiked.value = _post.likedByMe;
    _likesCount.value = _post.marksCount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 20),
      child: Row(
        children: [
          // Likes
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // TODO Ilya: может использовать напрямую тут Use Case?
              _feedPresenter.likePost(_post).next(
                onError: (e) {
                  // Ставит состояние обратно
                  _setActualLikeState();

                  // Передаем дальше, чтобы обработалось в зоне и юзер увидел что за ошибка была с лайком.
                  throw e;
                },
              );

              // Сразу реагирует на изменённое состояние
              _setActualLikeState();
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
                      style: AppTextStyles.semiBold15,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Comments
          GestureDetector(
            onTap: () {
              if (ModalRoute.of(context)!.settings.name == AppRoutes.post) {
                return;
              }

              Navigator.of(context).pushNamed(AppRoutes.post, arguments: _post.id);
            },
            child: Row(
              children: [
                const Icon(
                  AppIcons.comment_fill,
                  color: AppColors.white40,
                  size: 24,
                ),
                const SizedBox(width: 4),
                Text(
                  _post.commentsCount.toString(),
                  style: AppTextStyles.semiBold16.apply(color: AppColors.black60),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),

          // Bookmarks
          const Icon(
            AppIcons.bookmark_line,
            color: AppColors.white40,
            size: 24,
          ),
          const Spacer(),

          // Views
          const Icon(
            AppIcons.eye_line,
            color: AppColors.white40,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text(
            '${_post.viewsCount}',
            style: AppTextStyles.medium12.apply(color: AppColors.black20),
          )
        ],
      ),
    );
  }
}
