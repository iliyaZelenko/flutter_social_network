import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';

class ProfileEntity {
  final ProfileId id;
  final String nickname, firstName, lastName, avatar;
  final bool isVerified;
  final List<SubscriptionPlanEntity>? plans;

  const ProfileEntity({
    required this.id,
    // Объяснение о https://i.imgur.com/Dn9qmGw.png
    required this.nickname,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    this.plans,
    String? avatar,
  }) : avatar = avatar ?? 'https://i.imgur.com/xWGGZgV.png';

  String get fullName => '$firstName $lastName';

  // Мешает. Например, в обновлении профиля, когда один профиль меняется на другой с таким id, но что-то отличается, то нет обновления Observer
  // @override
  // List<Object?> get props => [
  //       id,
  //       nickname,
  //       avatar,
  //       firstName,
  //       lastName,
  //       isVerified,
  //     ];
}
