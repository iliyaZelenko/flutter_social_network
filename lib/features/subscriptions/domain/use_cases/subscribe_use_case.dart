import 'package:worker_manager/worker_manager.dart';

import '../repositories/subscriptions_repository.dart';
import '../value_objects/subscription_plan_id.dart';

class SubscribeUseCase {
  final SubscriptionsRepository _subscriptionsRepository;

  SubscribeUseCase(this._subscriptionsRepository);

  Cancelable<void> execute(SubscriptionPlanId id) {
    return _subscriptionsRepository.subscribe(id);
  }
}
