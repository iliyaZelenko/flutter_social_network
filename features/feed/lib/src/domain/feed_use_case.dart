import 'package:worker_manager/worker_manager.dart';

import 'entities/feed_response_entity.dart';
import 'repositories/feed_repository.dart';

class FeedUseCase {
  final FeedRepository _feedRepository;

  FeedResponseEntity? _feed;

  FeedResponseEntity? get feed => _feed;

  FeedUseCase(this._feedRepository);

  Cancelable<void> fetch({String? next}) {
    return _feedRepository.fetch(next: next).next(
      onValue: (value) {
        _feed = value;
      },
    );
  }
}
