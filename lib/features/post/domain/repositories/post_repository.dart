import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/entities/post_screen_entity.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class PostRepository {
  Cancelable<PostScreenEntity> get(PostId id);

  // Returns actual count of likes
  Cancelable<int> like(PostId id);
}
