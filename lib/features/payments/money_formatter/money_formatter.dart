import 'package:rate_club/features/payments/domain/value_objects/money.dart';

import '../domain/entities/currency_entity.dart';
import 'money_formatter_interface.dart';

class MoneyFormatter implements MoneyFormatterInterface {
  @override
  String format(Money money) {
    // TODO Ilya: display cents if needed (no toStringAsFixed)
    final val = (money.amountInCents / 100).toStringAsFixed(0);
    final currencySymbol = getCurrencySymbol(money.currency);
    final re = RegExp('(\\d)(?=(\\d{3})+(?!\\d))');

    return '${val.replaceAllMapped(
      re,
      (match) => '${match.group(1)},',
    )}$currencySymbol';
  }

  String getCurrencySymbol(CurrencyEntity currencyEntity) {
    switch (currencyEntity.id.toString()) {
      case '840':
        return '\$';
      default:
        throw UnsupportedError('Unsupported currency with id ${currencyEntity.id}');
    }
  }
}
