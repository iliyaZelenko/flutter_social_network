import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';
import 'package:rate_club/features/payments/domain/value_objects/currency_id.dart';
import 'package:rate_club/features/payments/domain/value_objects/money.dart';
import 'package:rate_club/features/subscriptions/data/models/subscriptions_models.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';
import 'package:rate_club/features/subscriptions/domain/value_objects/subscription_plan_id.dart';

class PlanDtoToEntityMapper {
  SubscriptionPlanEntity map(PlanDto planDto) {
    return SubscriptionPlanEntity(
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
    );
  }
}
