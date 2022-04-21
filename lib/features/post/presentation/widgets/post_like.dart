import 'package:flutter/material.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/icons/icon_like.dart';
import 'package:rate_club/resources/icons/icon_like_on.dart';

// TODO Ilya: если лайкнул и открываешь первое состояние, то показывает анимация лайка
class PostLike extends StatelessWidget {
  static const double iconSize = 24;

  final ValueNotifier<bool> _isLiked;

  const PostLike({
    Key? key,
    required ValueNotifier<bool> isLiked,
  })  : _isLiked = isLiked,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLiked,
      builder: (ctx, value, __) {
        return value ? _LikeBody(key: UniqueKey(), animated: value) : const IconLike(size: PostLike.iconSize);
      },
    );
  }
}

class _LikeBody extends StatefulWidget {
  final bool animated;

  const _LikeBody({Key? key, this.animated = false}) : super(key: key);

  @override
  _LikeBodyState createState() => _LikeBodyState();
}

class _LikeBodyState extends State<_LikeBody> {
  bool _tapped = false;
  bool _animated = false;

  @override
  Widget build(BuildContext context) {
    _animated = widget.animated;

    const body = IconLikeOn(size: PostLike.iconSize);

    if (_animated) {
      return Stack(
        alignment: Alignment.center,
        children: [
          AnimatedScale(
            onEnd: () {
              setState(() {
                _tapped = false;
                _animated = false;
              });
            },
            curve: Curves.elasticOut,
            scale: _tapped ? 1.5 : 1,
            duration: Durations.duration500,
            child: body,
          ),
        ],
      );
    }
    return body;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.endOfFrame.then(
      (_) {
        if (mounted) {
          if (widget.animated) {
            setState(() {
              _tapped = true;
            });
          }
        }
      },
    );
  }
}
