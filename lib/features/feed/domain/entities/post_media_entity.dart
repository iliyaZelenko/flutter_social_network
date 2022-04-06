import 'package:rate_club/features/feed/domain/value_objects/media_id.dart';

class PostMediaEntity {
  final MediaId id;
  final String url;

  const PostMediaEntity({
    required this.id,
    required this.url,
  });
}
