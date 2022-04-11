import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'number_formatter/number_formatter.dart';
import 'number_formatter/number_formatter_interface.dart';
import 'plural/plural.dart';
import 'plural/plural_interface.dart';

class ToolsFeature extends FeatureInterface {
  late final InjectorInterface _injector;

  ToolsFeature({
    required InjectorInterface injector,
  }) : _injector = injector;

  @override
  void execute() {
    _injector
      ..map<PluralInterface>(
        (i) => Plural(),
        isSingleton: true,
      )
      ..map<NumberFormatterInterface>(
        (i) => NumberFormatter(),
        isSingleton: true,
      );
  }
}
