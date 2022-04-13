import 'dart:math';

import 'package:rate_club/features/feed/data/dto/feed_dto.dart';
import 'package:rate_club/features/feed/data/mappers/feed_item_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_counters.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
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
          results: responseDto.results
              .map(
                (item) => item == null ? _makeErrorPost() : _postEntityMapper.map(item),
              )
              .toList(),
        );
      },
    );
  }

  // TODO Ilya: pass error object and use his message
  PostOpenByPlanEntity _makeErrorPost() {
    final random = Random();

    return PostOpenByPlanEntity(
      id: PostId(random.nextInt(100)),
      creator: PostCreatorEntity(
        id: ProfileId(random.nextInt(100)),
        nickname: 'error_reporter',
        firstName: 'Error',
        lastName: 'Reporter',
        isVerified: true,
      ),
      title: 'Error when parsing post',
      content: 'TODO: error message',
      counters: PostCounters(
        comments: 0,
        marks: 0,
        viewed: 0,
      ),
      media: [],
    );
  }
}
