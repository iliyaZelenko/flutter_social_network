import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/repositories/profile_screen_repository.dart';
import 'package:worker_manager/worker_manager.dart';

class GetProfileScreenUseCase {
  final ProfileScreenRepository _repo;

  GetProfileScreenUseCase(this._repo);

  Cancelable<ProfileScreenEntity> execute(String nickname) {
    return _repo.fetch(nickname);
  }
}
