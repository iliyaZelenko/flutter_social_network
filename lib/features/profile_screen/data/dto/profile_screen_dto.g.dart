// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_screen_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileScreenDto _$ProfileScreenDtoFromJson(Map<String, dynamic> json) => ProfileScreenDto(
      json['id'] as int,
      json['nickname'] as String?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['is_verified'] as bool?,
      json['avatar'] == null ? null : ProfileAvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
      json['default'] as bool,
      json['about'] as String?,
      json['counters'] == null ? null : ProfileScreenCountersDto.fromJson(json['counters'] as Map<String, dynamic>),
    );

ProfileScreenCountersDto _$ProfileScreenCountersDtoFromJson(Map<String, dynamic> json) => ProfileScreenCountersDto(
      json['articles'] as int?,
      json['comments'] as int?,
      json['contracts'] as int?,
      json['subscribers'] as int?,
    );
