import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_counters.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';

class PostScreenEntity extends PostOpenByPlanEntity {
  PostScreenEntity({
    required PostId id,
    required String content,
    required String? title,
    required PostCounters counters,
    required PostCreatorEntity creator,
    required List<PostMediaEntity> media,
  }) : super(
          id: id,
          content: content,
          title: title,
          counters: counters,
          creator: creator,
          media: media,
        );

  @override
  bool operator ==(covariant PostScreenEntity other) => other.id == id;
}
