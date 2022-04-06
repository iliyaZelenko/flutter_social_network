import 'package:rate_club/features/payments/domain/entities/currency_entity.dart';

class Money {
  final int amountInCents;
  final CurrencyEntity currency;

  Money({
    required this.amountInCents,
    required this.currency,
  });
}
