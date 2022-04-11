import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';

import '../value_objects/post_counters.dart';
import 'post_creator_entity.dart';
import 'post_media_entity.dart';

class PostOpenByPlanEntity extends PostEntity {
  final String content;
  final String? title;
  final PostCounters counters;
  final List<PostMediaEntity> media;

  PostOpenByPlanEntity({
    required PostId id,
    required PostCreatorEntity creator,
    required this.content,
    required this.title,
    required this.counters,
    required this.media,
  }) : super(
          id: id,
          creator: creator,
        );
}