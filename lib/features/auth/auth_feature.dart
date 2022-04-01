import 'package:injector/injector.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repositories/auth_repository_impl.dart';
import 'domain/use_cases/log_out_use_case.dart';
import 'domain/use_cases/sign_in_use_case.dart';

class AuthFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  AuthFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  void execute() {
    _injector
      ..map<AuthRepositoryImpl>(
        (i) => AuthRepositoryImpl(_http),
        isSingleton: true,
      )
      ..map<SignInUseCase>(
        (i) => SignInUseCase(i.get<AuthRepositoryImpl>()),
        isSingleton: true,
      )
      ..map<LogOutUseCase>(
        (i) => LogOutUseCase(i.get<AuthRepositoryImpl>()),
        isSingleton: true,
      );
  }
}
