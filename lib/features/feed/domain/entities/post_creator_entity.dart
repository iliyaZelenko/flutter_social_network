class PostCreatorEntity {
  const PostCreatorEntity({
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
}
