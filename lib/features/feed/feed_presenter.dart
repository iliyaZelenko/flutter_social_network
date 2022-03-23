import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:feed/feed.dart';
import 'package:flutter/foundation.dart';

class FeedPresenter extends Presenter {
  final FeedUseCase _feedUseCase;

  FeedPresenter(this._feedUseCase);

  final _loading = ValueNotifier(false);
  final index = ValueNotifier(0);

  ValueListenable<bool> get loading => _loading;

  ValueStream<FeedResponseEntity?> get feed => stream(() => _feedUseCase.feed);

  @override
  onLayout() {
    initFetch();
  }

  Future<void> initFetch() {
    _feedUseCase.fetch();

    return runAndUpdate(
      beforeAction: () {
        _loading.value = true;
      },
      action: () async {
        await _feedUseCase.fetch();

        _loading.value = false;
      },
      onError: (e) => _loading.value = false,
    );
  }

  Future<void> refresh() {
    return Future.value(null);
  }

  // void fetchMore () {
  //
  // }
}
