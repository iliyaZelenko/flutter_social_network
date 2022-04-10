import 'package:rate_club/features/other_profile/data/models/other_profile_models.dart';
import 'package:rate_club/features/other_profile/domain/entities/other_profile_entity.dart';
import 'package:rate_club/features/other_profile/domain/repositories/other_profile_repository.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class OtherProfileRepositoryImpl implements OtherProfileRepository {
  final AppHttpClientInterface _http;

  OtherProfileRepositoryImpl(this._http);

  @override
  Cancelable<OtherProfileEntity> fetch(String username) {
    return _http.get<Map<String, dynamic>>(path: 'profile/$username').next(
      onValue: (response) {
        return _fromProfileDtoToProfile(OtherProfileDto.fromJson(response.data!));
      },
    );
  }

  OtherProfileEntity _fromProfileDtoToProfile(OtherProfileDto model) {
    return OtherProfileEntity(
      id: ProfileId(model.id),
      username: model.username!,
      avatar: model.avatar?.defaultType,
      firstName: model.firstName!,
      lastName: model.lastName!,
      isVerified: model.isVerified!,
    );
  }
}
