import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/resources/global_events/events/AbstractGlobalEvent.dart';

class LikeGlobalEvent extends AbstractGlobalEvent {
  final PostId postId;
  final bool likedByMe;
  final int likesCount;

  LikeGlobalEvent({
    required this.postId,
    required this.likedByMe,
    required this.likesCount,
  });
}
