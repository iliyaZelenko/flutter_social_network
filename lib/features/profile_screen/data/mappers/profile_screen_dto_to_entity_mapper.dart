import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';
import 'package:rate_club/features/payments/domain/value_objects/currency_id.dart';
import 'package:rate_club/features/payments/domain/value_objects/money.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/profile_screen/data/dto/profile_screen_dto.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/value_objects/profile_screen_counters.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';
import 'package:rate_club/features/subscriptions/domain/value_objects/subscription_plan_id.dart';
import 'package:rate_club/resources/helpers.dart';

class ProfileScreenDtoToEntityMapper {
  ProfileScreenEntity map(ProfileScreenDto dto) {
    // TODO Ilya: duplicated code to mapper
    final plans = dto.plans
        .map((planDto) => SubscriptionPlanEntity(
              id: SubscriptionPlanId(planDto.id),
              title: planDto.title,
              cost: Money(
                amountInCents: planDto.cost.toInt() * 100,
                currency: CurrencyEntity(
                  id: CurrencyId(planDto.currency),
                ),
              ),
              isActive: planDto.isActive,
              activeCoid: planDto.activeCoid,
            ))
        .toList();
    final plansInfo = getPlansInfo(plans);

    return ProfileScreenEntity(
      id: ProfileId(dto.pid),
      nickname: dto.nickname,
      avatar: dto.avatar?.defaultType,
      firstName: dto.firstName!,
      lastName: dto.lastName!,
      isVerified: dto.isVerified,
      about: dto.about,
      counters: ProfileScreenCounters(
        articles: dto.counters?.articles ?? 0,
        comments: dto.counters?.comments ?? 0,
        contracts: dto.counters?.contracts ?? 0,
        tokens: dto.counters?.tokens ?? 0,
        subscribers: dto.counters?.subscribers ?? 0,
      ),
      subscriptionFreeActive: plansInfo.subscriptionFreeActive!,
      subscriptionPremiumActive: plansInfo.subscriptionPremiumActive!,
      subscriptionPremiumActiveCoid: plansInfo.subscriptionPremiumActiveCoid,
      subscriptionFreeActiveCoid: plansInfo.subscriptionFreeActiveCoid,
    );
  }
}
