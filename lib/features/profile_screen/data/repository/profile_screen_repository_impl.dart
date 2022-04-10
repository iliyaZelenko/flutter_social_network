import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/profile_screen/data/models/profile_screen_models.dart';
import 'package:rate_club/features/profile_screen/domain/entities/other_profile_entity.dart';
import 'package:rate_club/features/profile_screen/domain/repositories/profile_screen_repository.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileScreenRepositoryImpl implements ProfileScreenRepository {
  final AppHttpClientInterface _http;

  ProfileScreenRepositoryImpl(this._http);

  @override
  Cancelable<ProfileScreenEntity> fetch(String username) {
    return _http.get<Map<String, dynamic>>(path: 'profile/$username').next(
      onValue: (response) {
        return _fromProfileScreenDtoToProfile(ProfileScreenDto.fromJson(response.data!));
      },
    );
  }

  ProfileScreenEntity _fromProfileScreenDtoToProfile(ProfileScreenDto model) {
    return ProfileScreenEntity(
      id: ProfileId(model.id),
      username: model.username!,
      avatar: model.avatar?.defaultType,
      firstName: model.firstName!,
      lastName: model.lastName!,
      isVerified: model.isVerified!,
      about: model.about,
    );
  }
}
