import 'package:rate_club/features/post/domain/entities/post_comment_media_entity.dart';
import 'package:rate_club/features/post/domain/value_objects/post_id.dart';

class PostCommentEntity {
  final PostCommentId id;
  final String content;
  final Set<PostCommentMediaEntity> media;

  PostCommentEntity({
    required this.id,
    required this.content,
    required this.media,
  });

  @override
  bool operator ==(covariant PostCommentEntity other) => other.id == id;
}
