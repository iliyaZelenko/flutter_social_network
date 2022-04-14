import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class LikePostUseCase {
  final PostRepository _postRepo;

  LikePostUseCase(this._postRepo);

  Cancelable<int> execute(PostOpenByPlanEntity post) {
    _changeEntity(post);

    return _postRepo.like(post.id).next(onError: (e) {
      // Revert state back
      _changeEntity(post);

      return Cancelable.justError(e);
    });
  }

  void _changeEntity(PostOpenByPlanEntity post) {
    if (post.likedByMe) {
      post.marksCount--;
      post.likedByMe = false;
    } else {
      post.marksCount++;
      post.likedByMe = true;
    }
  }
}
