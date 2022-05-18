import 'package:json_annotation/json_annotation.dart';
import 'package:rate_club/features/profile/data/models/profile_models.dart';
import 'package:rate_club/features/subscriptions/data/models/subscriptions_models.dart';

part 'profile_screen_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileScreenDto extends ProfileDto {
  final String? about;
  final ProfileScreenCountersDto? counters;
  final List<PlanDto> plans;

  ProfileScreenDto(
    int pid,
    String nickname,
    String? firstName,
    String? lastName,
    bool isVerified,
    ProfileAvatarDto? avatar,
    bool isDefault,
    this.about,
    this.counters,
    this.plans,
  ) : super(
          pid,
          nickname,
          firstName,
          lastName,
          isVerified,
          avatar,
          isDefault,
        );

  factory ProfileScreenDto.fromJson(Map<String, dynamic> json) => _$ProfileScreenDtoFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileScreenCountersDto {
  final int? articles;
  final int? comments;
  // TODO Ilya: бэкенд пока возвращал пустой массив, там это не готово. Поэтому пока заглушка.
  final int? tokens = 0;
  final int? contracts;
  final int? subscribers;

  ProfileScreenCountersDto(
    this.articles,
    this.comments,
    this.contracts,
    this.subscribers,
  );

  factory ProfileScreenCountersDto.fromJson(Map<String, dynamic> json) => _$ProfileScreenCountersDtoFromJson(json);
}
