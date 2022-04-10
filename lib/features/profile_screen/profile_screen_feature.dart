import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repository/profile_screen_repository_impl.dart';
import 'domain/use_cases/get_profile_screen_use_case.dart';

class ProfileScreenFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  ProfileScreenFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  @override
  void execute() {
    final repo = ProfileScreenRepositoryImpl(_http);
    final getProfileScreenUseCase = GetProfileScreenUseCase(repo);

    _injector
      ..map<ProfileScreenRepositoryImpl>(
        (i) => repo,
        isSingleton: true,
      )
      ..map<GetProfileScreenUseCase>(
        (i) => getProfileScreenUseCase,
        isSingleton: true,
      );
  }
}
