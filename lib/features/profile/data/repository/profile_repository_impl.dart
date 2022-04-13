import 'package:rate_club/features/profile/data/models/profile_models.dart';
import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/repositories/profile_repository.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AppHttpClientInterface _http;

  ProfileRepositoryImpl(this._http);

  @override
  Cancelable<ProfileEntity> fetch() {
    return _http.get<Map<String, dynamic>>(path: 'profile/', handleOnUnauthorized: false).next(
      onValue: (response) {
        final resDto = ProfileResponseDto.fromJson(response.data!);
        // Берётся первый дефолтный профиль. Обсудили что пока делаем так. Но в идеале как я вижу, нужно брать профиль под которым логинишься
        final defaultProfileDto = resDto.results.firstWhere((profile) => profile.isDefault);

        return _fromProfileDtoToProfile(defaultProfileDto);
      },
    );
  }

  ProfileEntity _fromProfileDtoToProfile(ProfileDto model) {
    return ProfileEntity(
      id: ProfileId(model.id),
      nickname: model.nickname,
      avatar: model.avatar?.defaultType,
      firstName: model.firstName!,
      lastName: model.lastName!,
      isVerified: model.isVerified,
    );
  }
}
