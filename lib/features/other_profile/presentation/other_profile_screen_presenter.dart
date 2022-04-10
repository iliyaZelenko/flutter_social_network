import 'package:mobx/mobx.dart';
import 'package:rate_club/features/other_profile/domain/entities/other_profile_entity.dart';
import 'package:rate_club/features/other_profile/domain/use_cases/get_other_profile_use_case.dart';
import 'package:rate_club/features/profile/presentation/abstract_profile_screen_presenter.dart';

part 'other_profile_screen_presenter.g.dart';

class OtherProfileScreenPresenter = OtherProfileScreenPresenterBase with _$OtherProfileScreenPresenter;

abstract class OtherProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final String _username;
  final GetOtherProfileUseCase _getOtherProfileUseCase;

  OtherProfileScreenPresenterBase({
    required String username,
    required GetOtherProfileUseCase getOtherProfileUseCase,
  })  : _username = username,
        _getOtherProfileUseCase = getOtherProfileUseCase;

  @override
  @computed
  OtherProfileEntity? get profile => _fetchedProfile;

  @readonly
  OtherProfileEntity? _fetchedProfile;

  @readonly
  bool _loading = false;

  @override
  @action
  Future<void> fetch() async {
    _loading = true;
    _fetchedProfile = await _getOtherProfileUseCase.execute(_username);
    _loading = false;
  }

  @override
  @action
  Future<void> refresh() async {
    _fetchedProfile = await _getOtherProfileUseCase.execute(_fetchedProfile!.username);
  }
}
