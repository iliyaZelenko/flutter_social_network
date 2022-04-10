// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_screen_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileScreenDto _$ProfileScreenDtoFromJson(Map<String, dynamic> json) =>
    ProfileScreenDto(
      json['id'] as int,
      json['username'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['is_verified'] as bool?,
      json['avatar'] == null
          ? null
          : ProfileAvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      json['default'] as bool,
      json['about'] as String?,
    );
