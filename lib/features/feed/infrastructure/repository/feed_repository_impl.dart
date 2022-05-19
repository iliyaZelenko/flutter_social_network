import 'dart:math';

import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/infrastructure/dto/feed_dto.dart';
import 'package:rate_club/features/feed/infrastructure/mappers/feed_item_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';
import 'package:rate_club/features/payments/domain/value_objects/currency_id.dart';
import 'package:rate_club/features/payments/domain/value_objects/money.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';
import 'package:rate_club/features/subscriptions/domain/value_objects/subscription_plan_id.dart';
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
          count: responseDto.count,
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
      id: PostId(99999999999 + random.nextInt(100)),
      creator: PostCreatorEntity(
        id: ProfileId(99999999999 + random.nextInt(100)),
        nickname: 'error_reporter',
        firstName: 'Error',
        lastName: 'Reporter',
        isVerified: true,
        plans: [
          SubscriptionPlanEntity(
            id: SubscriptionPlanId(123),
            title: 'Premium',
            cost: Money(
              amountInCents: 100,
              currency: CurrencyEntity(id: CurrencyId(840)),
            ),
          ),
          SubscriptionPlanEntity(
            id: SubscriptionPlanId(123),
            title: 'Other plan (free)',
            cost: Money(
              amountInCents: 0,
              currency: CurrencyEntity(id: CurrencyId(840)),
            ),
          ),
        ],
      ),
      createdAt: DateTime.now(),
      likedByMe: false,
      title: 'Error when parsing post',
      content: 'TODO: error message',
      viewsCount: 0,
      commentsCount: 0,
      likesCount: 0,
      media: [],
    );
  }
}
