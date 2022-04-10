import 'package:mobx/mobx.dart';
import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';

import 'abstract_profile_screen_presenter.dart';

part 'my_profile_screen_presenter.g.dart';

class MyProfileScreenPresenter = MyProfileScreenPresenterBase with _$MyProfileScreenPresenter;

abstract class MyProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final ProfilePresenter _profilePresenter;

  MyProfileScreenPresenterBase({
    required ProfilePresenter profilePresenter,
  }) : _profilePresenter = profilePresenter;

  // TODO Ilya: is refresh working? If not, then use local variable to overwrite
  @override
  @computed
  ProfileEntity get profile => _profilePresenter.profile!;

  @override
  bool get loading => false;

  @override
  @action
  Future<void> fetch() async {}

  @override
  @action
  Future<void> refresh() async {
    _profilePresenter.fetch();
  }
}
