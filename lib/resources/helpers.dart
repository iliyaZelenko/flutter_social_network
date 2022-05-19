// TODO Ilya: no helpers (antipattern)

import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';

PlansInfo getPlansInfo(Iterable<SubscriptionPlanEntity> plans) {
  final premiumPlan = plans.firstWhere((element) => element.title == 'Premium');
  final freePlan = plans.firstWhere((element) => element != premiumPlan);

  return PlansInfo(
    premiumPlan: premiumPlan,
    freePlan: freePlan,
    subscriptionPremiumActive: premiumPlan.isActive,
    subscriptionFreeActive: freePlan.isActive,
    subscriptionPremiumActiveCoid: premiumPlan.activeCoid,
    subscriptionFreeActiveCoid: freePlan.activeCoid,
  );
}

class PlansInfo {
  final SubscriptionPlanEntity premiumPlan;
  final SubscriptionPlanEntity freePlan;
  final bool? subscriptionPremiumActive;
  final bool? subscriptionFreeActive;
  final int? subscriptionPremiumActiveCoid;
  final int? subscriptionFreeActiveCoid;

  PlansInfo({
    required this.premiumPlan,
    required this.freePlan,
    this.subscriptionPremiumActive,
    this.subscriptionFreeActive,
    this.subscriptionPremiumActiveCoid,
    this.subscriptionFreeActiveCoid,
  });
}
