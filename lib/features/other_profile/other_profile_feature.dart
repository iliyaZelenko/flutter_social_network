import 'package:injector/injector.dart';
import 'package:rate_club/features/other_profile/presentation/other_profile_presenter.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repository/other_profile_repository_impl.dart';
import 'domain/use_cases/get_other_profile_use_case.dart';

class OtherProfileFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  OtherProfileFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  @override
  void execute() {
    final repo = OtherProfileRepositoryImpl(_http);
    final getOtherProfileUseCase = GetOtherProfileUseCase(repo);

    _injector
      ..map<OtherProfileRepositoryImpl>(
        (i) => repo,
        isSingleton: true,
      )
      ..map<GetOtherProfileUseCase>(
        (i) => getOtherProfileUseCase,
        isSingleton: true,
      )
      ..map<OtherProfilePresenter>(
        (i) => OtherProfilePresenter(getOtherProfileUseCase: getOtherProfileUseCase),
        isSingleton: true,
      );
  }
}
