import 'package:rate_club/features/post/domain/value_objects/post_comment_media_id.dart';

class PostCommentMediaEntity {
  final PostCommentMediaId id;
  final String url;

  const PostCommentMediaEntity({
    required this.id,
    required this.url,
  });
}
