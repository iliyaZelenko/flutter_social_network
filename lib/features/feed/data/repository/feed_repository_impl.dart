import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/repositories/feed_repository.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_counters.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/rate_club.dart';

class FeedRepositoryImpl implements FeedRepository {
  final AppHttpClientInterface _http;

  FeedRepositoryImpl(this._http);

  @override
  Cancelable<FeedResponse> get({String? next}) {
    return _http
        .get(
      host: next == null ? null : '',
      path: next ?? 'wall/',
    )
        .next(
      onValue: (response) {
        return FeedResponse(
          next: response.body['next'] as String?,
          results: List<Map<String, dynamic>>.from(response.body['results'] as Iterable<dynamic>)
              .where((element) => element['article']['content_type'] == 'article')
              .map(_fromPostDtoToPostEntity)
              .toList(),
        );
      },
    );
  }

  PostEntity _fromPostDtoToPostEntity(Map<String, dynamic> dto) {
    final creator = dto['creator'];
    final article = dto['article'];

    // const mediaMock = [
    //   PostMediaEntity(id: 1, url: 'https://i.imgur.com/nhuOytU.jpeg'),
    //   PostMediaEntity(id: 2, url: 'https://i.imgur.com/NErzmhn.jpeg'),
    // ];

    return PostEntity(
      id: PostId(article['id'] as int),
      content: article['content'] ?? '<Нет контента>',
      title: article['title'],
      counters: PostCounters(
        viewed: article['counters']['viewed'] ?? 0,
        comments: article['counters']['comments'] ?? 0,
        marks: article['counters']['marks'] ?? 0,
      ),
      creator: PostCreatorEntity(
        id: creator['pid'],
        username: creator['username'] ?? 'nousername',
        avatar: 'https://' + (creator['avatar']?['default']?['url'] ?? 'i.imgur.com/QHyTGKE.png'),
        firstName: creator['first_name'] ?? 'no first name',
        lastName: creator['last_name'] ?? 'no last name',
        isVerified: creator['is_verified'] ?? false,
      ),
      media: (article['media'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((e) => PostMediaEntity(
                id: e['id'],
                url: 'https://' + e['url'],
              ))
          .toList(),
    );
  }
}
