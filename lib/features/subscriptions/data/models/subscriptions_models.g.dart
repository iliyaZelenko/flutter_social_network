// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetByProfileResponseDto _$GetByProfileResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GetByProfileResponseDto(
      (json['results'] as List<dynamic>)
          .map((e) => PlanDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PlanDto _$PlanDtoFromJson(Map<String, dynamic> json) => PlanDto(
      json['id'] as int,
      json['title'] as String,
      json['is_active'] as bool,
      (json['cost'] as num).toDouble(),
      json['currency'] as int,
      json['active_coid'] as int?,
    );
