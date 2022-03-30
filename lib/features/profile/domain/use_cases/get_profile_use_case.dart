import 'package:rate_club/features/profile/domain/entities/profile.dart';
import 'package:rate_club/features/profile/domain/repositories/profile_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class GetProfileUseCase {
  final ProfileRepository _profileRepo;

  GetProfileUseCase(ProfileRepository this._profileRepo);

  Cancelable<Profile> execute() {
    return _profileRepo.fetch();
  }
}