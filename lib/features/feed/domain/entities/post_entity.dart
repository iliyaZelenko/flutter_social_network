import '../value_objects/post_counters.dart';
import '../value_objects/post_id.dart';
import 'post_creator_entity.dart';
import 'post_media_entity.dart';

class PostEntity {
  final PostId id;
  final String content;
  final PostCounters counters;
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
