import 'package:rate_club/features/profile/domain/entities/profile_entity.dart';
import 'package:rate_club/features/profile/domain/repositories/profile_repository.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileRepositoryMock implements ProfileRepository {
  @override
  Cancelable<ProfileEntity> fetch() {
    return Durations.defaultDurationCancelable.next(onValue: (_) {
      return ProfileEntity(
        id: ProfileId(3525235),
        nickname: 'Jhon',
        avatar: 'https://dev.easydev.group/public/13/34/2022/3/11/1.jpg',
        firstName: 'Петя',
        lastName: 'Пупкин',
        isVerified: false,
      );
    });
  }
}
