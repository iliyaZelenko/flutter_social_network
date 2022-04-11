import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class ProfileScreenRepository {
  Cancelable<ProfileScreenEntity> fetch(String username);
}
