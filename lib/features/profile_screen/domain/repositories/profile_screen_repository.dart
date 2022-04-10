import 'package:rate_club/features/profile_screen/domain/entities/other_profile_entity.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class ProfileScreenRepository {
  Cancelable<ProfileScreenEntity> fetch(String username);
}
