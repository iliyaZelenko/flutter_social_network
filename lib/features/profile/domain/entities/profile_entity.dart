import 'package:equatable/equatable.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';

class ProfileEntity extends Equatable {
  final ProfileId id;
  final String nickname, firstName, lastName, avatar;
  final bool isVerified;

  const ProfileEntity({
    required this.id,
    // Объяснение о https://i.imgur.com/Dn9qmGw.png
    required this.nickname,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    String? avatar,
  }) : avatar = avatar ?? 'https://i.imgur.com/xWGGZgV.png';

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        nickname,
        avatar,
        firstName,
        lastName,
        isVerified,
      ];
}
