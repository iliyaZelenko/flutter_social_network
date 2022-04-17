import 'dart:math';

import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/infrastructure/dto/feed_dto.dart';
import 'package:rate_club/features/feed/infrastructure/mappers/feed_item_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/post/data/dto/post_comment_dto.dart';
import 'package:rate_club/features/post/data/mappers/post_comment_dto_to_entity_mapper.dart';
import 'package:rate_club/features/post/domain/entities/post_comment_entity.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:rate_club/features/post/domain/value_objects/post_comments_response.dart';
import 'package:rate_club/features/post/domain/value_objects/post_id.dart';
import 'package:rate_club/rate_club.dart';

class PostRepositoryImpl implements PostRepository {
  final AppHttpClientInterface _http;
  final FeedItemDtoToPostEntityMapper _postEntityMapper;
  final PostCommentDtoToEntityMapper _postCommentMapper;

  PostRepositoryImpl(
    this._http,
    this._postEntityMapper,
    this._postCommentMapper,
  );

  @override
  Cancelable<PostEntity> get(PostId id) {
    return _http
        .get<Map<String, dynamic>>(
          path: 'wall/posts/$id',
        )
        .next(
          onValue: (response) => _postEntityMapper.map(FeedResponseItemDto.fromJson(response.data!)),
        );
  }

  // status — true if like, false if unlike
  @override
  Future<void> like(PostId id, [bool status = true]) async {
    await _http.post(
      path: 'wall/$id/${status ? '' : 'un'}like/',
    );
  }

  @override
  Cancelable<PostCommentsResponse> comments({
    required PostId id,
    String? next,
  }) {
    return _http
        .get<Map<String, dynamic>>(
      path: 'wall/$id/0/comments/',
    )
        .next(
      onValue: (response) {
        final responseDto = PostCommentsResponseDto.fromJson(response.data!);

        return PostCommentsResponse(
          next: responseDto.next,
          results: responseDto.results
              .map(
                (item) => item == null ? _makeErrorComment() : _postCommentMapper.map(item),
              )
              .toSet(),
        );
      },
    );
  }

  PostCommentEntity _makeErrorComment() {
    final random = Random();

    return PostCommentEntity(
      id: PostCommentId(99999999999 + random.nextInt(100)),
      content: '<Error during parsing comment>',
      media: {},
    );
  }
}
