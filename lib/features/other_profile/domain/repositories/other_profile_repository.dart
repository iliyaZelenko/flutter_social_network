import 'package:rate_club/features/other_profile/domain/entities/other_profile_entity.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class OtherProfileRepository {
  Cancelable<OtherProfileEntity> fetch(String username);
}
