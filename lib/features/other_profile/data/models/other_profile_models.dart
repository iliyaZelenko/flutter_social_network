import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/profile/data/models/profile_models.dart';

part 'other_profile_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class OtherProfileDto extends ProfileDto {
  OtherProfileDto(
    int id,
    String? username,
    String? firstName,
    String? lastName,
    bool? isVerified,
    ProfileAvatarDto? avatar,
    bool isDefault,
  ) : super(
          id,
          username,
          firstName,
          lastName,
          isVerified,
          avatar,
          isDefault,
        );

  factory OtherProfileDto.fromJson(Map<String, dynamic> json) => _$OtherProfileDtoFromJson(json);
}
