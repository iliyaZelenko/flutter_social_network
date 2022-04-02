import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repository/feed_repository_impl.dart';
import 'domain/repositories/feed_repository.dart';
import 'domain/use_cases/get_feed_use_case.dart';
import 'presentation/feed_presenter.dart';

class FeedFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  FeedFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  void execute() {
    _injector
      ..map<FeedRepository>(
        (i) => FeedRepositoryImpl(_http),
        isSingleton: true,
      )
      ..map<GetFeedUseCase>(
        (i) => GetFeedUseCase(i.get<FeedRepository>()),
        isSingleton: true,
      )
      ..map<FeedPresenter>(
        (i) => FeedPresenter(getFeedUseCase: i.get<GetFeedUseCase>()),
        isSingleton: true,
      );
  }
}
