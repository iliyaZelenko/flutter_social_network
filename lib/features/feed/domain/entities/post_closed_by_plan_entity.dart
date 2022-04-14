import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/subscriptions/domain/entities/subscription_plan.dart';

import '../value_objects/post_id.dart';

class PostClosedByPlanEntity extends PostEntity {
  final SubscriptionPlanEntity needBuyPlan;

  PostClosedByPlanEntity({
    // Base class properties
    required PostId id,
    required PostCreatorEntity creator,

    // This class properties
    required this.needBuyPlan,
  }) : super(
          id: id,
          creator: creator,
        );
}
