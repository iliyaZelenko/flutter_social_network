import 'package:rate_club/features/feed/domain/value_objects/post_media_id.dart';

class PostMediaEntity {
  final PostMediaId id;
  final String url;

  const PostMediaEntity({
    required this.id,
    required this.url,
  });
}
