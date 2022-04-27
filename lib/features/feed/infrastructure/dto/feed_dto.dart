import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/profile/data/models/profile_models.dart';

part 'feed_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class FeedResponseDto {
  final String? next;

  final int count;

  @JsonKey(fromJson: _readResults)
  final List<FeedResponseItemDto?> results;

  FeedResponseDto(
    this.next,
    this.count,
    this.results,
  );

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) => _$FeedResponseDtoFromJson(json);

  static List<FeedResponseItemDto?> _readResults(dynamic json) {
    return (json as List).cast<Map<String, dynamic>>().map((e) {
      try {
        return FeedResponseItemDto.fromJson(e);
      } catch (e) {
        print(e);

        // null if error post
        return null;
      }
    }).toList();
  }
}

// TODO Ilya: "comment" from the backend
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class FeedResponseItemDto {
  // id события
  final int id;
  final PostCreatorDto creator;
  final ArticleDto article;

  FeedResponseItemDto(
    this.id,
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

  // Следующих полей может не быть если это PostClosedByPlanEntity:
  final String? content;
  final String? title;
  final PostCountersDto? counters;
  final List<PostMediaDto>? media;
  final DateTime? createdAt;

  @JsonKey(name: 'is_ilike', defaultValue: false)
  final bool likedByMe;

  // recommended plan to buy to see this post (PostClosedByPlanEntity)
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
    this.createdAt,
    this.likedByMe,
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
  final int viewed, comments;

  @JsonKey(
    name: 'marks',
  )
  final int likes;

  PostCountersDto(
    this.viewed,
    this.comments,
    this.likes,
  );

  factory PostCountersDto.fromJson(Map<String, dynamic> json) => _$PostCountersDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostMediaDto {
  final int id;

  @JsonKey(fromJson: _readUrl)
  final String url;

  const PostMediaDto(
    this.id,
    this.url,
  );

  factory PostMediaDto.fromJson(Map<String, dynamic> json) => _$PostMediaDtoFromJson(json);

  static String _readUrl(String value) => 'https://$value';
}
