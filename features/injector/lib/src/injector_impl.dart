import 'package:flutter_simple_dependency_injection/injector.dart' as injectorImport;

import 'injector_interface.dart';

class InjectorImpl extends InjectorInterface {
  late final _injector = injectorImport.Injector();

  @override
  T get<T>({String? key, Map<String, dynamic>? additionalParameters}) {
    return _injector.get<T>(
      key: key,
      additionalParameters: additionalParameters,
    );
  }

  @override
  Iterable<T> getAll<T>({Map<String, dynamic>? additionalParameters}) {
    return _injector.getAll<T>(
      additionalParameters: additionalParameters,
    );
  }

  @override
  InjectorInterface map<T>(
    ObjectFactoryFn<T, injectorImport.Injector> factoryFn, {
    bool isSingleton = false,
    String? key,
    bool allowFutureReassignment = false,
  }) {
    _injector.map<T>(
      factoryFn,
      isSingleton: isSingleton,
      key: key,
      allowFutureReassignment: allowFutureReassignment,
    );

    return this;
  }
}
