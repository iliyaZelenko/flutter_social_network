import 'package:rate_club/features/post/domain/entities/post_comment_entity.dart';

class PostCommentsResponse {
  final String? next;
  final Set<PostCommentEntity> results;

  PostCommentsResponse({
    required this.next,
    required this.results,
  });
}
