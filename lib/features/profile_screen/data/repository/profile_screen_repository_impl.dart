import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/profile_screen/data/dto/profile_screen_dto.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/repositories/profile_screen_repository.dart';
import 'package:rate_club/features/profile_screen/domain/value_objects/profile_screen_counters.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileScreenRepositoryImpl implements ProfileScreenRepository {
  final AppHttpClientInterface _http;

  ProfileScreenRepositoryImpl(this._http);

  @override
  Cancelable<ProfileScreenEntity> fetch(String nickname) {
    return _http.get<Map<String, dynamic>>(path: 'profile/$nickname').next(
      onValue: (response) {
        return _fromProfileScreenDtoToEntity(ProfileScreenDto.fromJson(response.data!));
      },
    );
  }

  ProfileScreenEntity _fromProfileScreenDtoToEntity(ProfileScreenDto model) {
    return ProfileScreenEntity(
      id: ProfileId(model.id),
      nickname: model.nickname,
      avatar: model.avatar?.defaultType,
      firstName: model.firstName!,
      lastName: model.lastName!,
      isVerified: model.isVerified,
      about: model.about,
      counters: ProfileScreenCounters(
        articles: model.counters?.articles ?? 0,
        comments: model.counters?.comments ?? 0,
        contracts: model.counters?.contracts ?? 0,
        tokens: model.counters?.tokens ?? 0,
        subscribers: model.counters?.subscribers ?? 0,
      ),
    );
  }
}
