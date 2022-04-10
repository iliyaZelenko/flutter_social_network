import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';

class ProfileScreenEntity extends ProfileEntity {
  final String? about;

  const ProfileScreenEntity({
    required ProfileId id,
    required String username,
    required String firstName,
    required String lastName,
    required bool isVerified,
    String? avatar,
    this.about,
  }) : super(
          id: id,
          username: username,
          firstName: firstName,
          lastName: lastName,
          isVerified: isVerified,
          avatar: avatar,
        );
}
