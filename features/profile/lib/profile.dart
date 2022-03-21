library profile;

import 'package:rate_club/rate_club.dart';
import 'package:profile/src/data/repository/profile_repository_impl.dart';
import 'package:profile/src/domain/profile_use_case.dart';

export 'src/domain/profile_use_case.dart';
export 'src/domain/entities/profile.dart';

ProfileUseCase profileUseCase(AppHttpClientInterface http) =>
    ProfileUseCase(ProfileRepositoryImpl(http));
