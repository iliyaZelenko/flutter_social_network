import 'package:rate_club/features/payments/domain/value_objects/money.dart';

import '../value_objects/subscription_plan_id.dart';

class SubscriptionPlanEntity {
  final SubscriptionPlanId id;
  final String title;
  final Money cost;
  final bool? isDefault;
  final bool? isActive;
  // Еслть при получении профиля, но, например, нет в /api/plan/<id>/list/
  final int? activeCoid;

  SubscriptionPlanEntity({
    required this.id,
    required this.title,
    required this.cost,
    this.isDefault,
    this.isActive,
    this.activeCoid,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant SubscriptionPlanEntity other) => other.id == id;
}
