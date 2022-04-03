import 'package:injector/injector.dart';
import 'package:rate_club/features/post/domain/use_cases/get_post_use_case.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/rate_club.dart';

import 'data/repository/post_repository_impl.dart';
import 'domain/repositories/post_repository.dart';

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
    _injector
      ..map<PostRepository>(
        (i) => PostRepositoryImpl(_http),
        isSingleton: true,
      )
      ..map<GetPostUseCase>(
        (i) => GetPostUseCase(i.get<PostRepository>()),
        isSingleton: true,
      )
      ..map<PostPresenter>(
        (i) => PostPresenter(getPostUseCase: i.get<GetPostUseCase>()),
      );
  }
}