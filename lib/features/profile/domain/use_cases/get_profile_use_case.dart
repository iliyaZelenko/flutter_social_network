import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/repositories/profile_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class GetProfileUseCase {
  final ProfileRepository _profileRepo;

  GetProfileUseCase(this._profileRepo);

  Cancelable<ProfileEntity> execute() {
    return _profileRepo.fetch();
  }
}
