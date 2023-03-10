import 'package:injector/injector.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/features/subscriptions/data/mappers/plan_dto_to_entity_mapper.dart';
import 'package:rate_club/rate_club.dart';

import 'data/mappers/profile_dto_to_entity_mapper.dart';
import 'data/repository/profile_repository_impl.dart';
import 'domain/use_cases/get_profile_use_case.dart';

class ProfileFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  ProfileFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  @override
  void execute() {
    _injector
      ..map<ProfileRepositoryImpl>(
        (i) => ProfileRepositoryImpl(
          _http,
          ProfileDtoToEntityMapper(i.get<PlanDtoToEntityMapper>()),
        ),
        isSingleton: true,
      )
      ..map<GetProfileUseCase>(
        (i) => GetProfileUseCase(i.get<ProfileRepositoryImpl>()),
        isSingleton: true,
      )
      ..map<ProfilePresenter>(
        (i) => ProfilePresenter(getProfileUseCase: i.get<GetProfileUseCase>()),
        isSingleton: true,
      );
  }
}
