import 'package:injector/injector.dart';
import 'package:rate_club/features/env/env_registry.dart';
import 'package:rate_club/features/env/env_variables.dart';
import 'package:rate_club/rate_club.dart';

class HttpFeature extends FeatureInterface {
  late final InjectorInterface _injector;

  HttpFeature({
    required InjectorInterface injector,
  }) : _injector = injector;

  Future<void> execute() async {
    final reg = _injector.get<EnvRegistry>();
    final isDebug = reg.get<bool>(EnvVariables.debug);
    final http = AppHttpClient(
      log: isDebug,
      fakeIsolate: isDebug,
      // TODO Ilya: take from getter to depend dynamically
      defaultHost: reg.get<String>(EnvVariables.APIBaseURL),
    );

    await http.init();

    _injector..map<AppHttpClientInterface>((i) => http, isSingleton: true);
  }
}
