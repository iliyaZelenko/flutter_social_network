import 'package:mobx/mobx.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/entities/post_screen_entity.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_use_case.dart';
import 'package:rate_club/features/post/domain/use_cases/like_post_use_case.dart';

part 'post_presenter.g.dart';

class PostPresenter = PostPresenterBase with _$PostPresenter;

abstract class PostPresenterBase with Store {
  final GetPostUseCase _getPostUseCase;
  final LikePostUseCase _likePostUseCase;

  PostPresenterBase({
    required GetPostUseCase getPostUseCase,
    required LikePostUseCase likePostUseCase,
  })  : _getPostUseCase = getPostUseCase,
        _likePostUseCase = likePostUseCase;

  @readonly
  bool _loading = false;

  @readonly
  PostScreenEntity? _post;

  @action
  Future<void> initFetch(PostId id) async {
    _loading = true;
    try {
      _post = await _getPostUseCase.execute(id);

      _loading = false;
    } catch (e) {
      _loading = false;

      rethrow;
    }
  }

  @action
  Future<void> refresh() async {
    _post = await _getPostUseCase.execute(_post!.id);
  }

  @action
  Future<void> like() async {
    // TODO Ilya _post.counters.marks =
    // await _likePostUseCase.execute(_post!.id);
  }
}
