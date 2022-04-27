import '../entities/post_entity.dart';

class FeedResponse {
  final String? next;
  final List<PostEntity> results;
  final int count;

  FeedResponse({
    required this.next,
    required this.results,
    required this.count,
  });
}
