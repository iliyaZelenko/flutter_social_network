// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedResponseDto _$FeedResponseDtoFromJson(Map<String, dynamic> json) =>
    FeedResponseDto(
      json['next'] as String?,
      FeedResponseDto._readResults(json['results']),
    );

FeedResponseItemDto _$FeedResponseItemDtoFromJson(Map<String, dynamic> json) =>
    FeedResponseItemDto(
      PostCreatorDto.fromJson(json['creator'] as Map<String, dynamic>),
      ArticleDto.fromJson(json['article'] as Map<String, dynamic>),
    );

PostCreatorDto _$PostCreatorDtoFromJson(Map<String, dynamic> json) =>
    PostCreatorDto(
      json['pid'] as int,
      json['nickname'] as String,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['is_verified'] as bool,
      json['avatar'] == null
          ? null
          : ProfileAvatarDto.fromJson(json['avatar'] as Map<String, dynamic>),
    );

ArticleDto _$ArticleDtoFromJson(Map<String, dynamic> json) => ArticleDto(
      json['id'] as int,
      json['content'] as String?,
      json['title'] as String?,
      json['counters'] == null
          ? null
          : PostCountersDto.fromJson(json['counters'] as Map<String, dynamic>),
      (json['media'] as List<dynamic>?)
          ?.map((e) => PostMediaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['recommend'] as int?,
      json['plan_details'] == null
          ? null
          : PlanDetailsDto.fromJson(
              json['plan_details'] as Map<String, dynamic>),
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['is_ilike'] as bool? ?? false,
    );

PlanDetailsDto _$PlanDetailsDtoFromJson(Map<String, dynamic> json) =>
    PlanDetailsDto(
      json['title'] as String,
      (json['cost'] as num).toDouble(),
      json['currency'] as int,
    );

PostCountersDto _$PostCountersDtoFromJson(Map<String, dynamic> json) =>
    PostCountersDto(
      json['viewed'] as int,
      json['comments'] as int,
      json['marks'] as int,
    );

PostMediaDto _$PostMediaDtoFromJson(Map<String, dynamic> json) => PostMediaDto(
      json['id'] as int,
      PostMediaDto._readUrl(json['url'] as String),
    );
