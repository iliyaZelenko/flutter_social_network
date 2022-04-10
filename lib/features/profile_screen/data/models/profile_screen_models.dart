import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/profile/data/models/profile_models.dart';

part 'profile_screen_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileScreenDto extends ProfileDto {
  final String? about;

  ProfileScreenDto(
    int id,
    String? username,
    String? firstName,
    String? lastName,
    bool? isVerified,
    ProfileAvatarDto? avatar,
    bool isDefault,
    this.about,
  ) : super(
          id,
          username,
          firstName,
          lastName,
          isVerified,
          avatar,
          isDefault,
        );

  factory ProfileScreenDto.fromJson(Map<String, dynamic> json) => _$ProfileScreenDtoFromJson(json);
}
