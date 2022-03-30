import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.username,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
  });

  final int id;
  final String username, avatar, firstName, lastName;
  final bool isVerified;

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        username,
        avatar,
        firstName,
        lastName,
        isVerified,
      ];
}
