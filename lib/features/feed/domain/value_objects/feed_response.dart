import '../entities/post_entity.dart';

class FeedResponse {
  final String? next;
  final List<PostEntity> results;

  FeedResponse({
    required this.next,
    required this.results,
  });
}
