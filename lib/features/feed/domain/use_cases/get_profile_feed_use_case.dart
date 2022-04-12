import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:worker_manager/worker_manager.dart';

class GetProfileFeedUseCase {
  final FeedRepository _feedRepo;

  GetProfileFeedUseCase(this._feedRepo);

  Cancelable<FeedResponse> execute({
    required String nickname,
    String? next,
  }) {
    return _feedRepo.get(nickname: nickname, next: next);
  }
}
