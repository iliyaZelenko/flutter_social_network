import 'package:rate_club/features/payments/domain/value_objects/money.dart';

import '../value_objects/subscription_plan_id.dart';

class SubscriptionPlanEntity {
  final SubscriptionPlanId id;
  final String title;
  final Money cost;

  SubscriptionPlanEntity({
    required this.id,
    required this.title,
    required this.cost,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant SubscriptionPlanEntity other) => other.id == id;
}
