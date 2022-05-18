import 'package:worker_manager/worker_manager.dart';

import '../repositories/subscriptions_repository.dart';

class CancelSubscriptionUseCase {
  final SubscriptionsRepository _subscriptionsRepository;

  CancelSubscriptionUseCase(this._subscriptionsRepository);

  Cancelable<void> execute(int activeCoid) {
    return _subscriptionsRepository.cancelSubscription(activeCoid);
  }
}
