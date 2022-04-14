import 'package:injector/injector.dart';
import 'package:rate_club/features/post/data/mappers/post_dto_to_post_entity_mapper.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_use_case.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repository/post_repository_impl.dart';
import 'domain/repositories/post_repository.dart';
import 'domain/use_cases/like_post_use_case.dart';

// TODO Ilya
// extension on AppRoutes {
//   static const post = 'post';
// }

class PostFeature extends FeatureInterface {
  late final InjectorInterface _injector;
  late final AppHttpClientInterface _http;

  PostFeature({
    required InjectorInterface injector,
    required AppHttpClientInterface http,
  })  : _injector = injector,
        _http = http;

  @override
  void execute() {
    final postRepo = PostRepositoryImpl(
      _http,
      PostDtoToPostScreenEntityMapper(),
    );

    _injector
      ..map<PostRepository>(
        (i) => postRepo,
        isSingleton: true,
      )
      ..map<GetPostUseCase>(
        (i) => GetPostUseCase(postRepo),
        isSingleton: true,
      )
      ..map<LikePostUseCase>(
        (i) => LikePostUseCase(postRepo),
        isSingleton: true,
      )
      // TODO Ilya(optimization): dynamically map with "key" or parameters based on postId? And then dispose (remove instance from Injector)
      ..map<PostPresenter>(
        (i) => PostPresenter(
          getPostUseCase: i.get<GetPostUseCase>(),
          likePostUseCase: i.get<LikePostUseCase>(),
        ),
      );
  }
}
