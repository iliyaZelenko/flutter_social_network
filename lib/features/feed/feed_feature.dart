import 'package:injector/injector.dart';
import 'package:rate_club/features/post/domain/use_cases/like_post_use_case.dart';
import 'package:rate_club/rate_club.dart';

import 'domain/repositories/feed_repository.dart';
import 'domain/use_cases/get_feed_use_case.dart';
import 'domain/use_cases/get_profile_feed_use_case.dart';
import 'infrastructure/mappers/feed_item_dto_to_post_entity_mapper.dart';
import 'infrastructure/repository/feed_repository_impl.dart';
import 'presentation/feed_presenter.dart';

class FeedFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  FeedFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  @override
  void execute() {
    _injector
      ..map<FeedRepository>(
        (i) => FeedRepositoryImpl(
          _http,
          FeedItemDtoToPostEntityMapper(),
        ),
        isSingleton: true,
      )
      ..map<GetFeedUseCase>(
        (i) => GetFeedUseCase(i.get<FeedRepository>()),
        isSingleton: true,
      )
      ..map<GetProfileFeedUseCase>(
        (i) => GetProfileFeedUseCase(i.get<FeedRepository>()),
        isSingleton: true,
      )
      ..map<FeedPresenter>(
        (i) => FeedPresenter(
          getFeedUseCase: i.get<GetFeedUseCase>(),
          likePostUseCase: i.get<LikePostUseCase>(),
        ),
        isSingleton: true,
      );
  }
}
