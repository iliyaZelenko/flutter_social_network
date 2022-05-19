import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';

class PostCreatorEntity extends ProfileEntity {
  const PostCreatorEntity({
    required ProfileId id,
    required String nickname,
    required String firstName,
    required String lastName,
    required bool isVerified,
    required List<SubscriptionPlanEntity> plans,
    String? avatar,
  }) : super(
          id: id,
          nickname: nickname,
          firstName: firstName,
          lastName: lastName,
          isVerified: isVerified,
          avatar: avatar,
          plans: plans,
        );
}
