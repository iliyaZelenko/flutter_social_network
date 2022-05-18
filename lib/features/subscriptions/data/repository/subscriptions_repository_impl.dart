import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';
import 'package:rate_club/features/payments/domain/value_objects/currency_id.dart';
import 'package:rate_club/features/payments/domain/value_objects/money.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/features/subscriptions/domain/value_objects/subscription_plan_id.dart';
import 'package:rate_club/rate_club.dart';

import '../../domain/entities/subscription_plan.dart';
import '../../domain/repositories/subscriptions_repository.dart';
import '../models/subscriptions_models.dart';

class SubscriptionsRepositoryImpl implements SubscriptionsRepository {
  final AppHttpClientInterface _http;

  SubscriptionsRepositoryImpl(this._http);

  @override
  Cancelable<List<SubscriptionPlanEntity>> getByProfile(ProfileId profileId) {
    return _http.get<Map<String, dynamic>>(path: 'plan/$profileId/list/').next(
      onValue: (response) {
        return GetByProfileResponseDto.fromJson(response.data!)
            .results
            .map(
              (planDto) => SubscriptionPlanEntity(
                id: SubscriptionPlanId(planDto.id),
                title: planDto.title,
                cost: Money(
                  amountInCents: planDto.cost.toInt() * 100,
                  currency: CurrencyEntity(
                    id: CurrencyId(planDto.currency),
                  ),
                ),
                isActive: planDto.isActive,
              ),
            )
            .toList();
      },
    );
  }

  @override
  Cancelable<void> subscribe(SubscriptionPlanId id) {
    return _http.post(path: 'plan/$id/subscribe/');
  }

  @override
  Cancelable<void> cancelSubscription(int activeCoid) {
    return _http.post(
      path: 'contract/$activeCoid/cancel/',
      body: {'reason': 'unknown'},
    );
  }
}
