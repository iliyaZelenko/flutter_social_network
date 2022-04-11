import 'package:mobx/mobx.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';

abstract class AbstractProfileScreenPresenter with Store {
  @computed
  ProfileScreenEntity? get profile;

  // Profile fetch/refresh status
  bool get loading;

  // Should set profile's info
  @action
  Future<void> fetch();

  // Should refresh profile's info
  @action
  Future<void> refresh();
}
