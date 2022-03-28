import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileDto {
  ProfileDto(
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.isVerified,
  );

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  final int id;
  final String? username, firstName, lastName;
  final bool? isVerified;
  late ProfileAvatarDto avatar;
}

class ProfileAvatarDto {
  final String defaultSet;

  ProfileAvatarDto(this.defaultSet);

  factory ProfileAvatarDto.fromJson(Map<String, dynamic> json) {
    return ProfileAvatarDto('https://' + json['default']['url']);
  }
}
