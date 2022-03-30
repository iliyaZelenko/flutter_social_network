import 'package:rate_club/features/profile/domain/entities/profile.dart';
import 'package:worker_manager/worker_manager.dart';

abstract class ProfileRepository {
  Cancelable<Profile> fetch();
}