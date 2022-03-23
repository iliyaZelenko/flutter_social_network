library feed;

import 'package:feed/src/data/repository/feed_repository_impl.dart';
import 'package:rate_club/rate_club.dart';

import 'src/domain/feed_use_case.dart';

export 'src/domain/entities/post_entity.dart';
export 'src/domain/entities/post_counters_entity.dart';
export 'src/domain/entities/feed_response_entity.dart';
export 'src/domain/feed_use_case.dart';

FeedUseCase feedUseCase(AppHttpClientInterface http) {
  return FeedUseCase(FeedRepositoryImpl(http));
}
