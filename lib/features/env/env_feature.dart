import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'env_registry.dart';
import 'env_variables.dart';

// Environment
class EnvFeature extends FeatureInterface {
  late final InjectorInterface _injector;

  EnvFeature({
    required InjectorInterface injector,
  }) : _injector = injector;

  Future<void> execute() async {
    final registry = EnvRegistry();

    registry.set(EnvVariables.debug, kDebugMode);
    registry.set(EnvVariables.APIBaseURL, 'https://dev.easydev.group/api/');

    _injector..map<EnvRegistry>((i) => registry, isSingleton: true);
  }
}
