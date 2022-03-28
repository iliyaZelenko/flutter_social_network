import 'package:rate_club/features/feed/domain/entities/feed_response_entity.dart';
import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class GetFeedUseCase {
  final FeedRepository _feedRepo;

  GetFeedUseCase(FeedRepository this._feedRepo);

  Cancelable<FeedResponseEntity> execute({String? next}) {
    return _feedRepo.fetch(next: next);
  }
}
