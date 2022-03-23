import 'package:feed/src/domain/entities/feed_response_entity.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class FeedRepository {
  Cancelable<FeedResponseEntity> fetch({String? next});
}
