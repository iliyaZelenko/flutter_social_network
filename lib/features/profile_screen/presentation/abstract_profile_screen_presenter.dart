import 'package:mobx/mobx.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';

abstract class AbstractProfileScreenPresenter with Store {
  @computed
  ProfileScreenEntity? get profile;

  // Profile fetch/refresh status
  bool get loading;

  List<PostEntity>? get posts;

  // Should set profile's info
  @action
  Future<void> fetch();

  // Should set feed info
  @action
  Future<void> fetchFeed();

  // Should refresh profile's info
  @action
  Future<void> refresh();
}
