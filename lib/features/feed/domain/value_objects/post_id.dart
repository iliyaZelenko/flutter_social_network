class PostId {
  final int _value;

  PostId(int value) : _value = value;

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(covariant PostId other) => other._value == _value;

  @override
  String toString() {
    return _value.toString();
  }
}
