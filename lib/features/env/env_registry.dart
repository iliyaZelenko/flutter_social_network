import 'env_variables.dart';

// Паттерн реестр
class EnvRegistry {
  late final Map<EnvVariables, dynamic> registry = {};

  void set(EnvVariables key, dynamic value) async {
    registry[key] = value;
  }

  T get<T>(EnvVariables key) {
    return registry[key] as T;
  }
}
