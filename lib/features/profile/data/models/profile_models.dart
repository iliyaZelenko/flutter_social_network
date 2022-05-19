import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/subscriptions/data/models/subscriptions_models.dart';

part 'profile_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileResponseDto {
  final List<ProfileDto> results;

  ProfileResponseDto(this.results);

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) => _$ProfileResponseDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileDto {
  final int pid;
  final String nickname;
  final String? firstName, lastName;
  final bool isVerified;
  final ProfileAvatarDto? avatar;
  final List<PlanDto> plans;

  @JsonKey(
    name: 'default',
  )
  final bool isDefault;

  ProfileDto(
    this.pid,
    this.nickname,
    this.firstName,
    this.lastName,
    this.isVerified,
    this.avatar,
    this.isDefault,
    this.plans,
  );

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProfileAvatarDto {
  @JsonKey(name: 'default', fromJson: _readTypeUrl)
  String defaultType;

  ProfileAvatarDto(this.defaultType);

  factory ProfileAvatarDto.fromJson(Map<String, dynamic> json) => _$ProfileAvatarDtoFromJson(json);

  static String _readTypeUrl(dynamic value) => 'https://${value['url'] as String}';
}
