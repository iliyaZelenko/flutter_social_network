import 'package:rate_club/features/profile/data/mappers/profile_dto_to_entity_mapper.dart';
import 'package:rate_club/features/profile/data/models/profile_models.dart';
import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/repositories/profile_repository.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AppHttpClientInterface _http;
  final ProfileDtoToEntityMapper _profileDtoToEntityMapper;

  ProfileRepositoryImpl(this._http, this._profileDtoToEntityMapper);

  @override
  Cancelable<ProfileEntity> fetch() {
    return _http.get<Map<String, dynamic>>(path: 'profile/', handleOnUnauthorized: false).next(
      onValue: (response) {
        final resDto = ProfileResponseDto.fromJson(response.data!);
        // Берётся первый дефолтный профиль. Обсудили что пока делаем так. Но в идеале как я вижу, нужно брать профиль под которым логинишься
        final defaultProfileDto = resDto.results.firstWhere((profile) => profile.isDefault);

        return _profileDtoToEntityMapper.map(defaultProfileDto);
      },
    );
  }
}
