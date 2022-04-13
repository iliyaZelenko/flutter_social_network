import 'package:rate_club/features/profile/data/models/profile_models.dart';
import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';

class ProfileDtoToEntityMapper {
  ProfileEntity map(ProfileDto model) {
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
