import 'package:equatable/equatable.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';

class ProfileEntity extends Equatable {
  final ProfileId id;
  final String username, firstName, lastName, avatar;
  final bool isVerified;

  const ProfileEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    String? avatar,
  }) : avatar = avatar ?? 'https://i.imgur.com/xWGGZgV.png';

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        username,
        avatar,
        firstName,
        lastName,
        isVerified,
      ];
}
