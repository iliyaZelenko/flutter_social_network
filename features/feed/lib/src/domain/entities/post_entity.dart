import 'package:feed/src/domain/entities/post_creator_entity.dart';
import 'package:feed/src/domain/entities/post_media_entity.dart';

import 'post_counters_entity.dart';

class PostEntity {
  final int id;
  final String content;
  final PostCountersEntity counters;
  final PostCreatorEntity creator;
  final List<PostMediaEntity> media;

  PostEntity({
    required this.id,
    required this.content,
    required this.counters,
    required this.creator,
    required this.media,
  });

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant PostEntity other) => other.id == id;
}
