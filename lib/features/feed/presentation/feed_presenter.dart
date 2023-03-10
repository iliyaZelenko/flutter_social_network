import 'package:mobx/mobx.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_feed_use_case.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';

part 'feed_presenter.g.dart';

class FeedPresenter = FeedPresenterBase with _$FeedPresenter;

abstract class FeedPresenterBase with Store {
  final GetFeedUseCase _getFeedUseCase;

  FeedPresenterBase({
    required GetFeedUseCase getFeedUseCase,
  }) : _getFeedUseCase = getFeedUseCase;

  @readonly
  bool _loading = false;

  @readonly
  FeedResponse? _feed;

  @action
  Future<void> initFetch() async {
    _loading = true;
    try {
      _feed = await _getFeedUseCase.execute();

      _loading = false;
    } catch (e) {
      _loading = false;

      rethrow;
    }
  }

  // TODO Ilya: refresh don't work (equatable don't helps)
  @action
  Future<void> refresh() async {
    _feed = await _getFeedUseCase.execute();
  }
}
