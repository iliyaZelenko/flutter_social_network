import 'dart:async';

import 'feature_interface.dart';

class FeatureInvoker {
  FutureOr<void> use(FeatureInterface feature) async {
    await feature.execute();
  }
}
