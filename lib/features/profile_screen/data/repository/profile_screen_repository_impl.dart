import 'package:rate_club/features/profile_screen/data/dto/profile_screen_dto.dart';
import 'package:rate_club/features/profile_screen/data/mappers/profile_screen_dto_to_entity_mapper.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/repositories/profile_screen_repository.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileScreenRepositoryImpl implements ProfileScreenRepository {
  final AppHttpClientInterface _http;
  final ProfileScreenDtoToEntityMapper _profileScreenMapper;

  ProfileScreenRepositoryImpl(this._http, this._profileScreenMapper);

  @override
  Cancelable<ProfileScreenEntity> fetch(String nickname) {
    return _http.get<Map<String, dynamic>>(path: 'profile/$nickname').next(
      onValue: (response) {
        return _profileScreenMapper.map(ProfileScreenDto.fromJson(response.data!));
      },
    );
  }
}
