import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class PostRepository {
  Cancelable<PostEntity> get(PostId id);

  // Returns actual count of likes
  Future<void> like(PostId id, [bool status = true]);
}
