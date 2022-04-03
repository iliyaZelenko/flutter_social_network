import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_counters.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/entities/post_screen_entity.dart';
import 'package:rate_club/features/post/domain/repositories/post_repository.dart';
import 'package:rate_club/rate_club.dart';

class PostRepositoryImpl implements PostRepository {
  final AppHttpClientInterface _http;

  PostRepositoryImpl(this._http);

  @override
  Cancelable<PostScreenEntity> get(PostId id) {
    return _http
        .get(
      path: '/article/$id',
    )
        .next(
      onValue: (response) {
        return _fromPostDtoToPostEntity(response.body);
      },
    );
  }

  PostScreenEntity _fromPostDtoToPostEntity(Map<String, dynamic> dto) {
    final creator = dto['creator'];
    // const mediaMock = [
    //   PostMediaEntity(id: 1, url: 'https://i.imgur.com/nhuOytU.jpeg'),
    //   PostMediaEntity(id: 2, url: 'https://i.imgur.com/NErzmhn.jpeg'),
    // ];

    return PostScreenEntity(
      id: PostId(dto['id']),
      content: dto['content'] ?? '',
      title: dto['title'],
      counters: PostCounters(
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
      media: (dto['media'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((e) => PostMediaEntity(
                id: e['id'],
                url: 'https://' + e['url'],
              ))
          .toList(),
    );
  }
}
