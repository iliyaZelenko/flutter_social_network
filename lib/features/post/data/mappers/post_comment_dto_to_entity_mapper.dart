import 'package:rate_club/features/post/data/dto/post_comment_dto.dart';
import 'package:rate_club/features/post/domain/entities/post_comment_entity.dart';
import 'package:rate_club/features/post/domain/entities/post_comment_media_entity.dart';
import 'package:rate_club/features/post/domain/value_objects/post_comment_media_id.dart';
import 'package:rate_club/features/post/domain/value_objects/post_id.dart';

class PostCommentDtoToEntityMapper {
  PostCommentEntity map(PostCommentDto dto) {
    return PostCommentEntity(
      id: PostCommentId(dto.id),
      content: dto.content ?? 'Need to buy a plan to see the comment',
      media: (dto.media ?? {})
          .map(
            (e) => PostCommentMediaEntity(
              id: PostCommentMediaId(e.id),
              url: e.url,
            ),
          )
          .toSet(),
    );
  }
}
