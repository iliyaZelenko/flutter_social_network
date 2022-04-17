import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/value_objects/post_comments_response.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class PostRepository {
  Cancelable<PostEntity> get(PostId id);

  // Returns actual count of likes
  Future<void> like(PostId id, [bool status = true]);

  Cancelable<PostCommentsResponse> comments({
    required PostId id,
    String? next,
  });
}
