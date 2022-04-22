import 'plural_interface.dart';

class Plural implements PluralInterface {
  @override
  String plural(
    int count,
    String one,
    String two,
    String five,
  ) {
    const cases = [2, 0, 1, 1, 1, 2];

    return [one, two, five][(count % 100 > 4 && count % 100 < 20) ? 2 : cases[(count % 10 < 5) ? count % 10 : 5]];
  }

  @override
  String pluralOneMany(
    int count,
    String one,
    String many,
  ) {
    return plural(count, one, many, many);
  }

  @override
  String pluralIterable(int count, Iterable<String> iterable) {
    return plural(count, iterable.elementAt(0), iterable.elementAt(1), iterable.elementAt(2));
  }
}
