import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';

class LikePostUseCase {
  final PostRepository _postRepo;

  LikePostUseCase(this._postRepo);

  Future<void> execute(PostOpenByPlanEntity post) {
    final likeStatus = !post.likedByMe;

    _changeEntity(post);

    return _postRepo.like(post.id, likeStatus).catchError((Object e) {
      // Revert state back
      _changeEntity(post);

      throw e;
    });
  }

  void _changeEntity(PostOpenByPlanEntity post) {
    if (post.likedByMe) {
      post.likesCount--;
      post.likedByMe = false;
    } else {
      post.likesCount++;
      post.likedByMe = true;
    }
  }
}
