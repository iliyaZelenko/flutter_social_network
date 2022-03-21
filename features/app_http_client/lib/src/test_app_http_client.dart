import '../app_http_client.dart';

class TestAppHttpClient extends AppHttpClient {
  TestAppHttpClient({
    bool log = false,
    Duration timeout = const Duration(seconds: 5),
    int delayInSeconds = 0,
    bool fakeIsolate = true,
  }) : super(
          timeout: timeout,
          delayInSeconds: delayInSeconds,
          fakeIsolate: fakeIsolate,
          log: log,
          tokensStorage: TokensStorage.test(),
        );
}
