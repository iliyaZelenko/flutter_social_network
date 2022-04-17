import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';

import 'post_creator_entity.dart';
import 'post_media_entity.dart';

class PostOpenByPlanEntity extends PostEntity {
  final String content;
  final String? title;
  final List<PostMediaEntity> media;
  final DateTime createdAt;
  bool likedByMe;

  int viewsCount;
  int commentsCount;
  // TODO Ilya: спросить, это кол-во лайков?
  int likesCount;

  PostOpenByPlanEntity({
    // Base class properties
    required PostId id,
    required PostCreatorEntity creator,

    // This class properties
    required this.content,
    required this.title,
    required this.media,
    required this.createdAt,
    required this.likedByMe,
    required this.viewsCount,
    required this.commentsCount,
    required this.likesCount,
  })  : assert(viewsCount >= 0 && commentsCount >= 0 && likesCount >= 0),
        super(
          id: id,
          creator: creator,
        );
}
