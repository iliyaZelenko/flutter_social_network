import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/data/dto/post_dto.dart';
import 'package:rate_club/features/post/data/mappers/post_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/post/domain/entities/post_screen_entity.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:rate_club/rate_club.dart';

class PostRepositoryImpl implements PostRepository {
  final AppHttpClientInterface _http;
  final PostDtoToPostScreenEntityMapper _postEntityMapper;

  PostRepositoryImpl(this._http, this._postEntityMapper);

  @override
  Cancelable<PostScreenEntity> get(PostId id) {
    return _http
        .get<Map<String, dynamic>>(
      path: '/article/$id',
    )
        .next(
      onValue: (response) {
        return _postEntityMapper.map(PostDto.fromJson(response.data!));
      },
    );
  }
}
