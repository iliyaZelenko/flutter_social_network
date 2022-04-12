import 'package:mobx/mobx.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/use_cases/get_profile_feed_use_case.dart';
import 'package:rate_club/features/feed/domain/value_objects/feed_response.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/features/profile_screen/domain/entities/profile_screen_entity.dart';
import 'package:rate_club/features/profile_screen/domain/use_cases/get_profile_screen_use_case.dart';

import '../abstract_profile_screen_presenter.dart';

part 'my_profile_screen_presenter.g.dart';

class MyProfileScreenPresenter = MyProfileScreenPresenterBase with _$MyProfileScreenPresenter;

abstract class MyProfileScreenPresenterBase with Store implements AbstractProfileScreenPresenter {
  final ProfilePresenter _profilePresenter;
  final GetProfileScreenUseCase _getProfileScreenUseCase;
  final GetProfileFeedUseCase _getProfileFeedUseCase;

  MyProfileScreenPresenterBase({
    required ProfilePresenter profilePresenter,
    required GetProfileScreenUseCase getProfileScreenUseCase,
    required GetProfileFeedUseCase getProfileFeedUseCase,
  })  : _profilePresenter = profilePresenter,
        _getProfileScreenUseCase = getProfileScreenUseCase,
        _getProfileFeedUseCase = getProfileFeedUseCase;

  @observable
  ProfileScreenEntity? _fetchedProfile;

  @observable
  FeedResponse? _feedResponse;

  String get _nickname => _profilePresenter.profile!.nickname;

  @override
  @computed
  ProfileScreenEntity? get profile => _fetchedProfile;

  @override
  @computed
  List<PostEntity>? get posts => _feedResponse?.results;

  @readonly
  bool _loading = false;

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
    _fetchedProfile = await _getProfileScreenUseCase.execute(_nickname);
  }
}
