import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:rate_club/features/post/domain/value_objects/post_comments_response.dart';
import 'package:worker_manager/worker_manager.dart';

class GetPostCommentsUseCase {
  final PostRepository _postRepo;

  GetPostCommentsUseCase(this._postRepo);

  Cancelable<PostCommentsResponse> execute({
    required PostId id,
    String? next,
  }) {
    return _postRepo.comments(id: id);
  }
}
