import 'package:mobx/mobx.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/value_objects/post_id.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_comments_use_case.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_use_case.dart';
import 'package:rate_club/features/post/domain/value_objects/post_comments_response.dart';

import '../domain/entities/post_comment_entity.dart';

part 'post_presenter.g.dart';

class PostPresenter = PostPresenterBase with _$PostPresenter;

abstract class PostPresenterBase with Store {
  final GetPostUseCase _getPostUseCase;
  final GetPostCommentsUseCase _getPostCommentsUseCase;

  PostPresenterBase({
    required GetPostUseCase getPostUseCase,
    required GetPostCommentsUseCase getPostCommentsUseCase,
  })  : _getPostUseCase = getPostUseCase,
        _getPostCommentsUseCase = getPostCommentsUseCase;

  @readonly
  bool _loading = false;

  @readonly
  PostEntity? _post;

  @readonly
  PostCommentsResponse? _postCommentsResponse;

  // TODO Ilya: observable list
  @readonly
  Set<PostCommentEntity>? _comments;

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
  Future<void> fetchComments(PostId id) async {
    _postCommentsResponse = await _getPostCommentsUseCase.execute(id: id);
    _comments = _postCommentsResponse!.results;
  }

  @action
  Future<void> refresh() async {
    _post = await _getPostUseCase.execute(_post!.id);
  }

  @action
  Future<void> addComment() async {
    // _comments.add('TODO')
  }
}
