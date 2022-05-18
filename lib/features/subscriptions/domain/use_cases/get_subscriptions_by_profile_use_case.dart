import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:worker_manager/worker_manager.dart';

import '../entities/subscription_plan.dart';
import '../repositories/subscriptions_repository.dart';

class GetSubscriptionsByProfileUseCase {
  final SubscriptionsRepository _subscriptionsRepository;

  GetSubscriptionsByProfileUseCase(this._subscriptionsRepository);

  Cancelable<List<SubscriptionPlanEntity>> execute(ProfileId profileId) {
    return _subscriptionsRepository.getByProfile(profileId);
  }
}
