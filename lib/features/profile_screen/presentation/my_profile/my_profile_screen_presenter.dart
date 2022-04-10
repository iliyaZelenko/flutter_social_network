import 'package:mobx/mobx.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/features/profile_screen/domain/entities/other_profile_entity.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';

import '../abstract_profile_screen_presenter.dart';

part 'my_profile_screen_presenter.g.dart';

class MyProfileScreenPresenter = MyProfileScreenPresenterBase with _$MyProfileScreenPresenter;

abstract class MyProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final ProfilePresenter _profilePresenter;
  final GetProfileScreenUseCase _getProfileScreenUseCase;

  MyProfileScreenPresenterBase({
    required ProfilePresenter profilePresenter,
    required GetProfileScreenUseCase getProfileScreenUseCase,
  })  : _profilePresenter = profilePresenter,
        _getProfileScreenUseCase = getProfileScreenUseCase;

  String get _userName => _profilePresenter.profile!.username;

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
    _fetchedProfile = await _getProfileScreenUseCase.execute(_userName);
    _loading = false;
  }

  @override
  @action
  Future<void> refresh() async {
    _fetchedProfile = await _getProfileScreenUseCase.execute(_userName);
  }
}
