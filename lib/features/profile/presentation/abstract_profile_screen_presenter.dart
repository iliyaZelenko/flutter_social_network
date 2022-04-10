import 'package:mobx/mobx.dart';
import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';

abstract class AbstractProfileScreenPresenter with Store {
  @computed
  ProfileEntity? get profile;

  // Profile fetch/refresh status
  bool get loading;

  // Should set profile's info
  @action
  Future<void> fetch();

  // Should refresh profile's info
  @action
  Future<void> refresh();
}
