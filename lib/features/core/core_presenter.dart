import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:profile/profile.dart';

class CorePresenter extends Presenter {
  ProfileUseCase _profileUseCase;

  CorePresenter(this._profileUseCase);

  Profile? get profile => _profileUseCase.profile;
}
