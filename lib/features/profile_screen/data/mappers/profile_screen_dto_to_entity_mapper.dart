import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/profile_screen/data/dto/profile_screen_dto.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/value_objects/profile_screen_counters.dart';

class ProfileScreenDtoToEntityMapper {
  ProfileScreenEntity map(ProfileScreenDto model) {
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
