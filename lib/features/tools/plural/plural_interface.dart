abstract class PluralInterface {
  String plural(
    int count,
    String one,
    String two,
    String five,
  );

  String pluralIterable(int count, Iterable<String> iterable);
}
