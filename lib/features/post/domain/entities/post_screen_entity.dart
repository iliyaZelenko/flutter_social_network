import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';

class PostScreenEntity extends PostOpenByPlanEntity {
  PostScreenEntity({
    required PostId id,
    required String content,
    required String? title,
    required PostCreatorEntity creator,
    required List<PostMediaEntity> media,
    required DateTime createdAt,
    required bool likedByMe,
    required int viewsCount,
    required int commentsCount,
    required int likesCount,
  }) : super(
          id: id,
          content: content,
          title: title,
          creator: creator,
          media: media,
          createdAt: createdAt,
          likedByMe: likedByMe,
          viewsCount: viewsCount,
          commentsCount: commentsCount,
          likesCount: likesCount,
        );

  @override
  bool operator ==(covariant PostScreenEntity other) => other.id == id;
}
