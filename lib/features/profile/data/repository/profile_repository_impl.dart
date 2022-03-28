import 'package:rate_club/features/profile/data/models/profile_models.dart';
import 'package:rate_club/features/profile/domain/entities/profile.dart';
import 'package:rate_club/features/profile/domain/repositories/profile_repository.dart';
import 'package:rate_club/rate_club.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final AppHttpClientInterface _http;

  ProfileRepositoryImpl(this._http);

  @override
  Cancelable<Profile> fetch() {
    return _http.get(path: 'profile/', handleOnUnauthorized: false).next(
          onValue: (response) {
            // Берётся первый дефолтный профиль. Обсудили что пока делаем так. Но в идеале как я вижу, нужно брать профиль под которым логинишься
            final defaultProfile = List.from(response.body['results']).firstWhere((element) => element['default']);

            return _fromProfileDtoToProfile(
              ProfileDto.fromJson(defaultProfile),
            );
          },
        );
  }

  Profile _fromProfileDtoToProfile(ProfileDto model) {
    return Profile(
      id: model.id,
      username: model.username!,
      avatar: model.avatar.defaultSet,
      firstName: model.firstName!,
      lastName: model.lastName!,
      isVerified: model.isVerified!,
    );
  }
}
