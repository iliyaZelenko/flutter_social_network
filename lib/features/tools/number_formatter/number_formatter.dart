import 'number_formatter_interface.dart';

class NumberFormatter implements NumberFormatterInterface {
  @override
  String formatWithWord(
    int count,
  ) {
    String result = count.toString();

    if (count >= 1000) {
      result = '${count / 1000}K';
    }
    if (count >= 1000000) {
      result = '${count / 1000000}M';
    }
    if (count >= 1000000000) {
      result = '${count / 1000000000}B';
    }

    return result;
  }

  // TODO Ilya: use in the future
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
