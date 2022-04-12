// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseDto _$ProfileResponseDtoFromJson(Map<String, dynamic> json) => ProfileResponseDto(
      (json['results'] as List<dynamic>).map((e) => ProfileDto.fromJson(e as Map<String, dynamic>)).toList(),
    );

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
      json['id'] as int,
      json['nickname'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['is_verified'] as bool?,
      json['avatar'] == null ? null : ProfileAvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      json['default'] as bool,
    );

ProfileAvatarDto _$ProfileAvatarDtoFromJson(Map<String, dynamic> json) => ProfileAvatarDto(
      ProfileAvatarDto._readTypeUrl(json, 'default') as String,
    );
