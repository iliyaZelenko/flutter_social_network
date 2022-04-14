import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/feed/infrastructure/dto/feed_dto.dart';

part 'post_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostDto {
  final int id;
  final PostCreatorDto creator;
  final String content;
  final String? title;
  final PostCountersDto counters;
  final List<PostMediaDto>? media;
  final PlanDetailsDto? planDetails;
  final DateTime createdAt;

  @JsonKey(name: 'is_ilike', defaultValue: false)
  final bool likedByMe;

  PostDto(
    this.id,
    this.creator,
    this.content,
    this.title,
    this.counters,
    this.media,
    this.planDetails,
    this.createdAt,
    this.likedByMe,
  );

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);
}
