import 'package:rate_club/features/feed/data/dto/feed_dto.dart';
import 'package:rate_club/features/feed/data/mappers/feed_item_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/rate_club.dart';

class FeedRepositoryImpl implements FeedRepository {
  final AppHttpClientInterface _http;
  final FeedItemDtoToPostEntityMapper _postEntityMapper;

  FeedRepositoryImpl(
    this._http,
    this._postEntityMapper,
  );

  @override
  Cancelable<FeedResponse> get({
    String? nickname,
    String? next,
  }) {
    return _http
        .get<Map<String, dynamic>>(
      host: next == null ? null : '',
      path: next ?? 'wall/${nickname ?? ''}',
    )
        .next(
      onValue: (response) {
        final responseDto = FeedResponseDto.fromJson(response.data!);

        return FeedResponse(
          next: responseDto.next,
          results: responseDto.results.map(_postEntityMapper.map).toList(),
        );
      },
    );
  }
}
