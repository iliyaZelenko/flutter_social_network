// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentsResponseDto _$PostCommentsResponseDtoFromJson(
        Map<String, dynamic> json) =>
    PostCommentsResponseDto(
      json['next'] as String?,
      PostCommentsResponseDto._readResults(json['results']),
    );

PostCommentDto _$PostCommentDtoFromJson(Map<String, dynamic> json) =>
    PostCommentDto(
      json['id'] as int,
      PostCommentDto._readContent(json['article'] as Map<String, dynamic>),
      (json['media'] as List<dynamic>?)
          ?.map((e) => PostCommentMediaDto.fromJson(e as Map<String, dynamic>))
          .toSet(),
    );

PostCommentMediaDto _$PostCommentMediaDtoFromJson(Map<String, dynamic> json) =>
    PostCommentMediaDto(
      json['id'] as int,
      PostCommentMediaDto._readUrl(json['url'] as String),
    );
