import 'package:rate_club/features/other_profile/domain/entities/other_profile_entity.dart';
import 'package:rate_club/features/other_profile/domain/repositories/other_profile_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class GetOtherProfileUseCase {
  final OtherProfileRepository _repo;

  GetOtherProfileUseCase(this._repo);

  Cancelable<OtherProfileEntity> execute(String username) {
    return _repo.fetch(username);
  }
}
