import 'package:rate_club/features/feed/domain/entities/post_creator_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_media_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/media_id.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_counters.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/data/dto/post_dto.dart';
import 'package:rate_club/features/post/domain/entities/post_screen_entity.dart';
import 'package:rate_club/features/profile/domain/value_objects/profile_id.dart';

class PostDtoToPostScreenEntityMapper {
  PostScreenEntity map(PostDto dto) {
    final creator = dto.creator;
    final creatorEntity = PostCreatorEntity(
      id: ProfileId(creator.pid),
      nickname: creator.nickname,
      avatar: creator.avatar?.defaultType ?? 'i.imgur.com/QHyTGKE.png',
      firstName: creator.firstName ?? 'Без имени',
      lastName: creator.lastName ?? 'Без фамилии',
      isVerified: creator.isVerified,
    );

    return PostScreenEntity(
      id: PostId(dto.id),
      content: dto.content,
      title: dto.title,
      counters: PostCounters(
        viewed: dto.counters.viewed,
        comments: dto.counters.comments,
        marks: dto.counters.marks,
      ),
      creator: creatorEntity,
      media: (dto.media ?? [])
          .map(
            (media) => PostMediaEntity(
              id: MediaId(media.id),
              url: media.url,
            ),
          )
          .toList(),
    );
  }
}
