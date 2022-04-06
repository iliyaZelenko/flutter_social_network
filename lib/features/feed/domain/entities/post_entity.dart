import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';

import '../value_objects/post_id.dart';

abstract class PostEntity {
  final PostId id;
  final PostCreatorEntity creator;

  PostEntity({
    required this.id,
    required this.creator,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant PostEntity other) => other.id == id;
}
