abstract class PluralInterface {
  String plural(
    int count,
    String one,
    String two,
    String five,
  );

  String pluralOneMany(
    int count,
    String one,
    String many,
  );

  String pluralIterable(int count, Iterable<String> iterable);
}
