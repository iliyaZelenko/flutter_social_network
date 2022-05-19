import 'package:rate_club/features/feed/domain/entities/post_closed_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_media_id.dart';
import 'package:rate_club/features/feed/infrastructure/dto/feed_dto.dart';
import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';
import 'package:rate_club/features/payments/domain/value_objects/currency_id.dart';
import 'package:rate_club/features/payments/domain/value_objects/money.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/data/mappers/plan_dto_to_entity_mapper.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';
import 'package:rate_club/features/subscriptions/domain/value_objects/subscription_plan_id.dart';

class FeedItemDtoToPostEntityMapper {
  PlanDtoToEntityMapper _planDtoToEntityMapper;

  FeedItemDtoToPostEntityMapper(this._planDtoToEntityMapper);

  PostEntity map(FeedResponseItemDto dto) {
    final creator = dto.creator;
    final article = dto.article;
    final creatorEntity = PostCreatorEntity(
      id: ProfileId(creator.pid),
      nickname: creator.nickname,
      avatar: creator.avatar?.defaultType ?? 'https://i.imgur.com/xWGGZgV.png',
      firstName: creator.firstName ?? 'Без имени',
      lastName: creator.lastName ?? 'Без фамилии',
      isVerified: creator.isVerified,
      plans: creator.plans.map(_planDtoToEntityMapper.map).toList(),
    );

    // const mediaMock = [
    //   PostMediaEntity(id: 1, url: 'https://i.imgur.com/nhuOytU.jpeg'),
    //   PostMediaEntity(id: 2, url: 'https://i.imgur.com/NErzmhn.jpeg'),
    // ];

    if (article.recommend == null) {
      // Поля который обозначены "!" приходят для PostOpenByPlanEntity
      return PostOpenByPlanEntity(
        id: PostId(dto.id),
        creator: creatorEntity,
        createdAt: article.createdAt!,
        likedByMe: article.likedByMe,
        content: article.content!,
        title: article.title,
        viewsCount: article.counters!.viewed,
        commentsCount: article.counters!.comments,
        likesCount: article.counters!.likes,
        media: (article.media ?? [])
            .map(
              (media) => PostMediaEntity(
                id: PostMediaId(media.id),
                url: media.url,
              ),
            )
            .toList(),
      );
    } else {
      // Информация для такого поста содержится в article.recommend и article.planDetails
      return PostClosedByPlanEntity(
        id: PostId(dto.id),
        creator: creatorEntity,
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
      );
    }
  }
}
