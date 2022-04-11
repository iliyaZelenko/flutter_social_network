import 'package:mobx/mobx.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';

part 'other_profile_screen_presenter.g.dart';

class OtherProfileScreenPresenter = OtherProfileScreenPresenterBase with _$OtherProfileScreenPresenter;

abstract class OtherProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final String _username;
  final GetProfileScreenUseCase _getProfileScreenUseCase;

  OtherProfileScreenPresenterBase({
    required String username,
    required GetProfileScreenUseCase getProfileScreenUseCase,
  })  : _username = username,
        _getProfileScreenUseCase = getProfileScreenUseCase;

  @override
  @computed
  ProfileScreenEntity? get profile => _fetchedProfile;

  @readonly
  ProfileScreenEntity? _fetchedProfile;

  @readonly
  bool _loading = false;

  @override
  @action
  Future<void> fetch() async {
    _loading = true;
    _fetchedProfile = await _getProfileScreenUseCase.execute(_username);
    _loading = false;
  }

  @override
  @action
  Future<void> refresh() async {
    _fetchedProfile = await _getProfileScreenUseCase.execute(_fetchedProfile!.username);
  }
}
