import 'package:rate_club/rate_club.dart';

abstract class TokensStorageKeys {
  static const String token = 'access';
  static const String refreshToken = 'refresh';
}

abstract class TokensStorage {
  factory TokensStorage() = _TokensStorageImpl;

  factory TokensStorage.test() = _TokensTestStorage;

  String? get token;

  String? get refreshToken;

  Future<void> init();

  Future<void> save(String? token, String? refreshToken);

  Future<void> clear();
}

class _TokensStorageImpl implements TokensStorage {
  late final SharedPreferences _storage;

  String? _token;
  String? _refreshToken;

  @override
  String? get token => _token;

  @override
  String? get refreshToken => _refreshToken;

  @override
  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
    _token = _storage.getString(TokensStorageKeys.token);
    _refreshToken = _storage.getString(TokensStorageKeys.refreshToken);
  }

  @override
  Future<void> save(String? token, String? refreshToken) async {
    if (token != null) {
      _token = token;
      await _storage.setString(TokensStorageKeys.token, token);
    }
    if (refreshToken != null) {
      _refreshToken = refreshToken;
      await _storage.setString(TokensStorageKeys.refreshToken, refreshToken);
    }
  }

  @override
  Future<void> clear() async {
    _token = null;
    _refreshToken = null;
    await _storage.remove(TokensStorageKeys.token);
    await _storage.remove(TokensStorageKeys.refreshToken);
  }
}

class _TokensTestStorage implements TokensStorage {
  @override
  String? token;

  @override
  String? refreshToken;

  @override
  Future<void> init() async {}

  @override
  Future<void> clear() async {
    token = null;
    refreshToken = null;
  }

  @override
  Future<void> save(String? token, String? refreshToken) async {
    if (token != null) {
      this.token = token;
    }
    if (refreshToken != null) {
      this.refreshToken = refreshToken;
    }
  }
}
