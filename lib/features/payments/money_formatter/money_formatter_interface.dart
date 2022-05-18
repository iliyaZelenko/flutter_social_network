import 'package:rate_club/features/payments/domain/value_objects/money.dart';

abstract class MoneyFormatterInterface {
  String format(Money money);
}
