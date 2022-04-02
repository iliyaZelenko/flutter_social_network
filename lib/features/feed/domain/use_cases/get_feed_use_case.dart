import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:worker_manager/worker_manager.dart';

class GetFeedUseCase {
  final FeedRepository _feedRepo;

  GetFeedUseCase(FeedRepository this._feedRepo);

  Cancelable<FeedResponse> execute({String? next}) {
    return _feedRepo.get(next: next);
  }
}
