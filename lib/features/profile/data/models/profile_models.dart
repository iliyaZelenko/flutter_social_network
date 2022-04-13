import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileResponseDto {
  final List<ProfileDto> results;

  ProfileResponseDto(this.results);

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) => _$ProfileResponseDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileDto {
  final int id;
  final String nickname;
  final String? firstName, lastName;
  final bool isVerified;
  final ProfileAvatarDto? avatar;

  @JsonKey(
    name: 'default',
  )
  final bool isDefault;

  ProfileDto(
    this.id,
    this.nickname,
    this.firstName,
    this.lastName,
    this.isVerified,
    this.avatar,
    this.isDefault,
  );

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProfileAvatarDto {
  @JsonKey(name: 'default', fromJson: _readTypeUrl)
  String defaultType;

  ProfileAvatarDto(this.defaultType);

  factory ProfileAvatarDto.fromJson(Map<String, dynamic> json) => _$ProfileAvatarDtoFromJson(json);

  static String _readTypeUrl(dynamic value) => 'https://' + (value['url'] as String);
}
