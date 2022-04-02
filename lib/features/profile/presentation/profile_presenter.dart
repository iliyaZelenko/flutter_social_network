import 'package:app_http_client/app_http_client.dart';
import 'package:mobx/mobx.dart';
import 'package:rate_club/features/profile/domain/entities/profile.dart';
import 'package:rate_club/features/profile/domain/use_cases/get_profile_use_case.dart';

part 'profile_presenter.g.dart';

class ProfilePresenter = ProfilePresenterBase with _$ProfilePresenter;

abstract class ProfilePresenterBase with Store {
  final GetProfileUseCase _getProfileUseCase;

  ProfilePresenterBase({
    required GetProfileUseCase getProfileUseCase,
  }) : _getProfileUseCase = getProfileUseCase;

  @observable
  Profile? profile;

  @action
  Future<void> fetch() async {
    try {
      profile = await _getProfileUseCase.execute();
    } catch (e) {
      if (e is HttpUnauthorizedException) {
        profile = null;
      } else {
        rethrow;
      }
    }
  }
}
