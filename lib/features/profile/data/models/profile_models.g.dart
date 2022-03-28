// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) => ProfileDto(
      json['id'] as int,
      json['username'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['is_verified'] as bool?,
    )..avatar =
        ProfileAvatarDto.fromJson(json['avatar'] as Map<String, dynamic>);
