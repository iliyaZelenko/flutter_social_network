import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/profile/data/models/profile_models.dart';

part 'feed_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class FeedResponseDto {
  final String next;
  final List<FeedResponseItemDto> results;

  FeedResponseDto(
    this.next,
    this.results,
  );

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) => _$FeedResponseDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class FeedResponseItemDto {
  final PostCreatorDto creator;
  final ArticleDto article;

  FeedResponseItemDto(
    this.creator,
    this.article,
  );

  factory FeedResponseItemDto.fromJson(Map<String, dynamic> json) => _$FeedResponseItemDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostCreatorDto {
  final int pid;
  final String nickname;
  final String? firstName, lastName;
  final bool isVerified;
  final ProfileAvatarDto? avatar;

  PostCreatorDto(
    this.pid,
    this.nickname,
    this.firstName,
    this.lastName,
    this.isVerified,
    this.avatar,
  );

  factory PostCreatorDto.fromJson(Map<String, dynamic> json) => _$PostCreatorDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ArticleDto {
  final int id;
  // Может не быть если это PostClosedByPlanEntity
  final String? content;
  final String? title;
  // Может не быть если это PostClosedByPlanEntity
  final PostCountersDto? counters;
  final List<PostMediaDto>? media;
  // recommended plan to buy to see this post
  final int? recommend;
  final PlanDetailsDto? planDetails;

  ArticleDto(
    this.id,
    this.content,
    this.title,
    this.counters,
    this.media,
    this.recommend,
    this.planDetails,
  );

  factory ArticleDto.fromJson(Map<String, dynamic> json) => _$ArticleDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PlanDetailsDto {
  final String title;
  final double cost;
  final int currency;

  PlanDetailsDto(
    this.title,
    this.cost,
    this.currency,
  );

  factory PlanDetailsDto.fromJson(Map<String, dynamic> json) => _$PlanDetailsDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostCountersDto {
  final int viewed, comments, marks;

  PostCountersDto(
    this.viewed,
    this.comments,
    this.marks,
  );

  factory PostCountersDto.fromJson(Map<String, dynamic> json) => _$PostCountersDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostMediaDto {
  final int id;

  @JsonKey(readValue: _readUrl)
  final String url;

  const PostMediaDto(
    this.id,
    this.url,
  );

  factory PostMediaDto.fromJson(Map<String, dynamic> json) => _$PostMediaDtoFromJson(json);

  static String _readUrl(dynamic json, key) => 'https://' + (json[key] as String);
}
