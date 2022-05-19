import 'package:rate_club/features/profile/data/models/profile_models.dart';
import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/data/mappers/plan_dto_to_entity_mapper.dart';

class ProfileDtoToEntityMapper {
  PlanDtoToEntityMapper planDtoToEntityMapper;

  ProfileDtoToEntityMapper(this.planDtoToEntityMapper);

  ProfileEntity map(ProfileDto dto) {
    final plans = dto.plans.map(planDtoToEntityMapper.map).toList();

    return ProfileEntity(
      id: ProfileId(dto.pid),
      nickname: dto.nickname,
      avatar: dto.avatar?.defaultType,
      firstName: dto.firstName!,
      lastName: dto.lastName!,
      isVerified: dto.isVerified,
      plans: plans,
    );
  }
}
