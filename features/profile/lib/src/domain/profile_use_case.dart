import 'package:worker_manager/worker_manager.dart';

import 'entities/profile.dart';
import 'profile_repository.dart';

class ProfileUseCase {
  final ProfileRepository _profileRepository;
  Profile? _profile;

  ProfileUseCase(this._profileRepository);

  Profile? get profile => _profile;

  bool get loggedIn => _profile != null;

  Cancelable<void> fetch() => _profileRepository.fetch().next(onValue: (profile) {
        _profile = profile;
      });
}
