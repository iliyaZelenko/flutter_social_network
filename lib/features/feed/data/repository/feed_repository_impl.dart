import 'package:rate_club/features/feed/data/dto/feed_dto.dart';
import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/feed/domain/value_objects/media_id.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_counters.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';
import 'package:rate_club/features/payments/domain/value_objects/currency_id.dart';
import 'package:rate_club/features/payments/domain/value_objects/money.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';
import 'package:rate_club/features/subscriptions/domain/value_objects/subscription_plan_id.dart';
import 'package:rate_club/rate_club.dart';

class FeedRepositoryImpl implements FeedRepository {
  final AppHttpClientInterface _http;

  FeedRepositoryImpl(this._http);

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
          results: responseDto.results.map(_fromFeedItemDtoToPostEntity).toList(),
        );
      },
    );
  }

  PostEntity _fromFeedItemDtoToPostEntity(FeedResponseItemDto dto) {
    final creator = dto.creator;
    final article = dto.article;
    final creatorEntity = PostCreatorEntity(
      id: ProfileId(creator.pid),
      nickname: creator.nickname,
      avatar: creator.avatar?.defaultType ?? 'i.imgur.com/QHyTGKE.png',
      firstName: creator.firstName ?? 'Без имени',
      lastName: creator.lastName ?? 'Без фамилии',
      isVerified: creator.isVerified,
    );

    // const mediaMock = [
    //   PostMediaEntity(id: 1, url: 'https://i.imgur.com/nhuOytU.jpeg'),
    //   PostMediaEntity(id: 2, url: 'https://i.imgur.com/NErzmhn.jpeg'),
    // ];

    if (article.recommend == null) {
      return PostOpenByPlanEntity(
        id: PostId(article.id),
        // content тут приходит всегда
        content: article.content!,
        title: article.title,
        counters: PostCounters(
          viewed: article.counters!.viewed,
          comments: article.counters!.comments,
          marks: article.counters!.marks,
        ),
        creator: creatorEntity,
        media: (article.media ?? [])
            .map(
              (media) => PostMediaEntity(
                id: MediaId(media.id),
                url: media.url,
              ),
            )
            .toList(),
      );
    } else {
      // Информация для такого поста содержится в article.recommend и article.planDetails
      return PostClosedByPlanEntity(
        id: PostId(article.id),
        needBuyPlan: SubscriptionPlanEntity(
          id: SubscriptionPlanId(article.recommend!),
          title: article.planDetails!.title,
          cost: Money(
            // TODO Ilya: remove toInt after backend fix
            amountInCents: article.planDetails!.cost.toInt() * 100,
            currency: CurrencyEntity(
              id: CurrencyId(article.planDetails!.currency),
            ),
          ),
        ),
        creator: creatorEntity,
      );
    }
  }
}
