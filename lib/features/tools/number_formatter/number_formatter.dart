import 'number_formatter_interface.dart';

class NumberFormatter implements NumberFormatterInterface {
  @override
  String formatWithWord(
    int count,
  ) {
    final formatedCount = _format(count);

    if (count >= 1000) {
      return '$formatedCount тыс';
    } else if (count >= 1000000) {
      return '$formatedCount млн';
    } else if (count >= 1000000000) {
      return '$formatedCount млрд';
    }

    return formatedCount;
  }

  String _format(
    num num, {
    int decimalLength = 0,
    int sectionsLength = 3,
    String delimiter = ',',
  }) {
    assert(decimalLength >= 0);

    final re = RegExp('\\d(?=(\\d{$sectionsLength})+${decimalLength > 0 ? '\\.' : '\$'})');

    return num.toStringAsFixed(decimalLength).replaceAllMapped(
      re,
      (match) => '${match.group(0)}$delimiter',
    );
  }
}
