import 'package:feed/feed.dart';
import 'package:feed/src/domain/entities/feed_response_entity.dart';
import 'package:feed/src/domain/entities/post_creator_entity.dart';
import 'package:feed/src/domain/repositories/feed_repository.dart';
import 'package:rate_club/rate_club.dart';

class FeedRepositoryImpl implements FeedRepository {
  final AppHttpClientInterface _http;

  FeedRepositoryImpl(this._http);

  @override
  Cancelable<FeedResponseEntity> fetch({String? next}) {
    return _http
        .get(
      host: next == null ? null : '',
      path: next ?? 'article/',
    )
        .next(
      onValue: (response) {
        return FeedResponseEntity(
          next: response.body['next'],
          results: List<Map<String, dynamic>>.from(response.body['results']).map(_fromPostDtoToPostEntity).toList(),
        );
      },
    );
  }

  PostEntity _fromPostDtoToPostEntity(Map<String, dynamic> dto) {
    final creator = dto['creator'];

    return PostEntity(
      id: dto['id'],
      content: dto['content'] ?? '',
      counters: PostCountersEntity(
        viewed: dto['viewed'] ?? 0,
        comments: dto['comments'] ?? 0,
        marks: dto['marks'] ?? 0,
      ),
      creator: PostCreatorEntity(
        id: creator['pid'],
        username: creator['username'] ?? 'nousername',
        avatar: 'https://' + (creator['avatar']?['default']?['url'] ?? 'i.imgur.com/QHyTGKE.png'),
        firstName: creator['first_name'] ?? 'no first name',
        lastName: creator['last_name'] ?? 'no last name',
        isVerified: creator['is_verified'] ?? false,
      ),
    );
  }
}
