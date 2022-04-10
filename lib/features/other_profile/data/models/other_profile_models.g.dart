// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherProfileDto _$OtherProfileDtoFromJson(Map<String, dynamic> json) => OtherProfileDto(
      json['id'] as int,
      json['username'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['is_verified'] as bool?,
      json['avatar'] == null ? null : ProfileAvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      json['default'] as bool,
    );
