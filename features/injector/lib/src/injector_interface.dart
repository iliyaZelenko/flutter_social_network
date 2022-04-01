typedef ObjectFactoryFn<T, I> = T Function(I injector);

abstract class InjectorInterface {
  // Maps the given type to the given factory function. Optionally specify the type as a singleton and give it a named key.
  //
  // [T] The type the [factoryFn] will return an instance of.
  //
  // [factoryFn] is a simple function which takes in an [Injector] and returns an new instance
  // of the type [T].  In this method you can use the injector to get other dependencies
  // this instance depends on (see examples below).
  //
  // When [isSingleton] is true the first returned instances of the object is stored and
  // subsequently return in future calls.
  //
  // When [key] is provided the object is keyed by type name and the given key.
  //
  // When [allowFutureReassignment] is provided the object mapping can be reassigned.
  //
  // Throws an [InjectorException] if the type and or key combination has already been mapped.
  //
  // Returns the current injector instance.
  //
  // ```dart
  // final injector = Injector.getInstance();
  // injector.map(Logger, (injector) => AppLogger());
  // injector.map(DbLogger, (injector) => DbLogger(), isSingleton: true);
  // injector.map(AppLogger, (injector) => AppLogger(injector.get(Logger)), key: "AppLogger");
  // injector.map(String, (injector) => "https://api.com/", key: "ApiUrl");
  // ```
  //
  // You can also configure mapping in a fluent programming style:
  // ```dart
  // Injector.getInstance().map(Logger, (injector) => AppLogger());
  //                       ..map(DbLogger, (injector) => DbLogger(), isSingleton: true);
  //                       ..map(AppLogger, (injector) => AppLogger(injector.get(Logger)), key: "AppLogger");
  //                       ..map(String, (injector) => "https://api.com/", key: "ApiUrl");
  // ```
  InjectorInterface map<T>(
    ObjectFactoryFn<T, dynamic> factoryFn, {
    bool isSingleton = false,
    String? key,
    bool allowFutureReassignment = false,
  });

  // Gets an instance of the given type of [T] and optional given key and parameters.
  //
  // Throws an [InjectorException] if the given type has not been mapped
  // using the map method.
  //
  // Note that instance that are mapped to need additional parameters cannot be singletons
  //
  T get<T>({String? key, Map<String, dynamic>? additionalParameters});

  // Gets all the mapped instances of the given type and additional parameters
  Iterable<T> getAll<T>({
    Map<String, dynamic>? additionalParameters,
  });
}
