import 'package:profile/src/domain/entities/profile.dart';
import 'package:profile/src/domain/profile_repository.dart';
import 'package:rate_club/resources/delays.dart';
import 'package:worker_manager/worker_manager.dart';

class ProfileRepositoryMock implements ProfileRepository {
  @override
  Cancelable<Profile> fetch() {
    return Delays.defaultDelayCancelable.next(onValue: (_) {
      return const Profile(
        id: 3525235,
        username: 'Jhon',
        avatar: 'https://dev.easydev.group/public/13/34/2022/3/11/1.jpg',
        firstName: 'Петя',
        lastName: 'Пупкин',
        isVerified: false,
      );
    });
  }
}
