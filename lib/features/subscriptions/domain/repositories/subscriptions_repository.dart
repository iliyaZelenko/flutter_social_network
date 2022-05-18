import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/rate_club.dart';

import '../entities/subscription_plan.dart';
import '../value_objects/subscription_plan_id.dart';

abstract class SubscriptionsRepository {
  Cancelable<List<SubscriptionPlanEntity>> getByProfile(ProfileId profileId);

  Cancelable<void> subscribe(SubscriptionPlanId id);

  Cancelable<void> cancelSubscription(int activeCoid);
}
