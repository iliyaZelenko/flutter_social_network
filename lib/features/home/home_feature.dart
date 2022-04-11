import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'presentation/home_presenter.dart';

class HomeFeature extends FeatureInterface {
  late final InjectorInterface _injector;

  HomeFeature({
    required InjectorInterface injector,
  }) : _injector = injector;

  @override
  void execute() {
    _injector.map<HomePresenter>(
      (i) => HomePresenter(),
      isSingleton: true,
    );
  }
}
