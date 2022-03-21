library auth;

import 'package:auth/src/data/auth_repository_impl.dart';
import 'package:rate_club/rate_club.dart';
import 'src/domain/auth_use_case.dart';

export 'src/domain/auth_use_case.dart';

AuthUseCase authUseCase(AppHttpClientInterface http) => AuthUseCase(AuthRepositoryImpl(http));
