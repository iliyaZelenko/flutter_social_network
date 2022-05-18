import 'package:injector/injector.dart';
import 'package:rate_club/features/payments/money_formatter/money_formatter_interface.dart';
import 'package:rate_club/rate_club.dart';

import 'money_formatter/money_formatter.dart';

class PaymentsFeature extends FeatureInterface {
  late final InjectorInterface _injector;

  PaymentsFeature({
    required InjectorInterface injector,
  }) : _injector = injector;

  @override
  void execute() {
    _injector.map<MoneyFormatterInterface>(
      (i) => MoneyFormatter(),
      isSingleton: true,
    );
  }
}
