// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDto _$PostDtoFromJson(Map<String, dynamic> json) => PostDto(
      json['id'] as int,
      PostCreatorDto.fromJson(json['creator'] as Map<String, dynamic>),
      json['content'] as String,
      json['title'] as String?,
      PostCountersDto.fromJson(json['counters'] as Map<String, dynamic>),
      (json['media'] as List<dynamic>?)
          ?.map((e) => PostMediaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['plan_details'] == null
          ? null
          : PlanDetailsDto.fromJson(
              json['plan_details'] as Map<String, dynamic>),
      DateTime.parse(json['created_at'] as String),
      json['is_ilike'] as bool? ?? false,
    );
