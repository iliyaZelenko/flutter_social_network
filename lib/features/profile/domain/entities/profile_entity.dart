import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const ProfileEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    String? avatar,
  }) : avatar = avatar ?? 'https://i.imgur.com/xWGGZgV.png';

  final int id;
  final String username, firstName, lastName, avatar;
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
