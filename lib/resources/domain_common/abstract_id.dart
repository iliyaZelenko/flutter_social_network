abstract class AbstractId<T> {
  final T _value;

  AbstractId(T value) : _value = value;

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(covariant AbstractId other) => other._value == _value;

  @override
  String toString() {
    return _value.toString();
  }
}
