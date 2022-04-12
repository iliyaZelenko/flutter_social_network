import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class FeedRepository {
  Cancelable<FeedResponse> get({
    String? nickname,
    String? next,
  });
}
