import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/infrastructure/dto/feed_dto.dart';
import 'package:rate_club/features/feed/infrastructure/mappers/feed_item_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:rate_club/rate_club.dart';

class PostRepositoryImpl implements PostRepository {
  final AppHttpClientInterface _http;
  final FeedItemDtoToPostEntityMapper _postEntityMapper;

  PostRepositoryImpl(this._http, this._postEntityMapper);

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
}
