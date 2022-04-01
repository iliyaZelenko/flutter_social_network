import 'package:injector/injector.dart';
import 'package:rate_club/main.dart';
import 'package:rate_club/rate_club.dart';

class HttpFeature extends FeatureInterface {
  late final InjectorInterface _injector;

  HttpFeature({
    required InjectorInterface injector,
  }) : _injector = injector;

  Future<void> execute() async {
    final http = AppHttpClient(
      log: debug,
      fakeIsolate: debug,
      defaultHost: 'https://dev.easydev.group/api/',
    );
    await http.init();

    _injector..map<AppHttpClientInterface>((i) => http, isSingleton: true);
    ;
  }
}
