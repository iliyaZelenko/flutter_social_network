import 'package:mobx/mobx.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_profile_feed_use_case.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';

part 'other_profile_screen_presenter.g.dart';

class OtherProfileScreenPresenter = OtherProfileScreenPresenterBase with _$OtherProfileScreenPresenter;

abstract class OtherProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final String _nickname;
  final GetProfileScreenUseCase _getProfileScreenUseCase;
  final GetProfileFeedUseCase _getProfileFeedUseCase;

  OtherProfileScreenPresenterBase({
    required String nickname,
    required GetProfileScreenUseCase getProfileScreenUseCase,
    required GetProfileFeedUseCase getProfileFeedUseCase,
  })  : _nickname = nickname,
        _getProfileScreenUseCase = getProfileScreenUseCase,
        _getProfileFeedUseCase = getProfileFeedUseCase;

  @readonly
  ProfileScreenEntity? _fetchedProfile;

  @readonly
  FeedResponse? _feedResponse;

  @override
  @computed
  ProfileScreenEntity? get profile => _fetchedProfile;

  @override
  @computed
  List<PostEntity>? get posts => _feedResponse?.results;

  @override
  @computed
  int? get postsCount => _feedResponse?.count;

  @readonly
  bool _loading = false;

  @override
  @observable
  int currentTab = 0;

  @override
  @action
  Future<void> fetch() async {
    _loading = true;
    _fetchedProfile = await _getProfileScreenUseCase.execute(_nickname);
    _loading = false;
  }

  @override
  @action
  Future<void> fetchFeed() async {
    _feedResponse = await _getProfileFeedUseCase.execute(nickname: _nickname);
  }

  @override
  @action
  Future<void> refresh() async {
    await Future.wait([
      _getProfileScreenUseCase.execute(_fetchedProfile!.nickname),
      fetchFeed(),
    ]);
  }
}
