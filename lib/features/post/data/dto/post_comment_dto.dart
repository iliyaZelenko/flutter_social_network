import 'package:json_annotation/json_annotation.dart';

part 'post_comment_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostCommentsResponseDto {
  final String? next;

  @JsonKey(fromJson: _readResults)
  final Set<PostCommentDto?> results;

  PostCommentsResponseDto(
    this.next,
    this.results,
  );

  factory PostCommentsResponseDto.fromJson(Map<String, dynamic> json) => _$PostCommentsResponseDtoFromJson(json);

  static Set<PostCommentDto?> _readResults(dynamic json) {
    return (json as List).cast<Map<String, dynamic>>().map((e) {
      try {
        return PostCommentDto.fromJson(e);
      } catch (e) {
        print(e);

        // null if error post
        return null;
      }
    }).toSet();
  }
}

// Тоже может быть закрыт по планну
@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostCommentDto {
  final int id;
  final Set<PostCommentMediaDto>? media;

  @JsonKey(name: 'article', fromJson: _readContent)
  final String? content;

  PostCommentDto(
    this.id,
    this.content,
    this.media,
  );

  factory PostCommentDto.fromJson(Map<String, dynamic> json) => _$PostCommentDtoFromJson(json);

  static String? _readContent(Map<String, dynamic> value) {
    return value['content'] as String?;
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class PostCommentMediaDto {
  final int id;

  @JsonKey(fromJson: _readUrl)
  final String url;

  const PostCommentMediaDto(
    this.id,
    this.url,
  );

  factory PostCommentMediaDto.fromJson(Map<String, dynamic> json) => _$PostCommentMediaDtoFromJson(json);

  static String _readUrl(String value) => 'https://$value';
}
