import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class GetPostUseCase {
  final PostRepository _postRepo;

  GetPostUseCase(this._postRepo);

  Cancelable<PostEntity> execute(PostId id) {
    return _postRepo.get(id);
  }
}
