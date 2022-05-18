import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repository/subscriptions_repository_impl.dart';
import 'domain/repositories/subscriptions_repository.dart';
import 'domain/use_cases/cancel_subscription_use_case.dart';
import 'domain/use_cases/get_subscriptions_by_profile_use_case.dart';
import 'domain/use_cases/subscribe_use_case.dart';

class SubscriptionsFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  SubscriptionsFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  @override
  void execute() {
    final repo = SubscriptionsRepositoryImpl(_http);

    _injector
      ..map<SubscriptionsRepository>(
        (i) => repo,
        isSingleton: true,
      )
      ..map<GetSubscriptionsByProfileUseCase>(
        (i) => GetSubscriptionsByProfileUseCase(repo),
        isSingleton: true,
      )
      ..map<SubscribeUseCase>(
        (i) => SubscribeUseCase(repo),
        isSingleton: true,
      )
      ..map<CancelSubscriptionUseCase>(
        (i) => CancelSubscriptionUseCase(repo),
        isSingleton: true,
      );
  }
}
