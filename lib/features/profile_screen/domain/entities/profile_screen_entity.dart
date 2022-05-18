import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/profile_screen/domain/value_objects/profile_screen_counters.dart';

class ProfileScreenEntity extends ProfileEntity {
  final String? about;
  final ProfileScreenCounters counters;
  final bool subscriptionFreeActive;
  final bool subscriptionPremiumActive;
  final int? subscriptionPremiumActiveCoid;
  final int? subscriptionFreeActiveCoid;

  const ProfileScreenEntity({
    required ProfileId id,
    required String nickname,
    required String firstName,
    required String lastName,
    required bool isVerified,
    required this.counters,
    required this.subscriptionFreeActive,
    required this.subscriptionPremiumActive,
    required this.subscriptionPremiumActiveCoid,
    required this.subscriptionFreeActiveCoid,
    String? avatar,
    this.about,
  }) : super(
          id: id,
          nickname: nickname,
          firstName: firstName,
          lastName: lastName,
          isVerified: isVerified,
          avatar: avatar,
        );
}
