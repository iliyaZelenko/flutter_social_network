import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class ProfileRepository {
  Cancelable<ProfileEntity> fetch();
}
