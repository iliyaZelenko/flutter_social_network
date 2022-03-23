import 'post_entity.dart';

class FeedResponseEntity {
  final String next;
  final List<PostEntity> results;

  FeedResponseEntity({
    required this.next,
    required this.results,
  });
}
