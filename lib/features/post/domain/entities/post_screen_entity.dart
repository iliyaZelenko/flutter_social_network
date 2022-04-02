import 'package:rate_club/features/feed/domain/entities/post_entity.dart';

class PostScreenEntity extends PostEntity {
  PostScreenEntity({
    required id,
    required content,
    required counters,
    required creator,
    required media,
  }) : super(
          id: id,
          content: content,
          counters: counters,
          creator: creator,
          media: media,
        );

  @override
  bool operator ==(covariant PostScreenEntity other) => other.id == id;
}
