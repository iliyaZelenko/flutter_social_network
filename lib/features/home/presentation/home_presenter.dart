import 'package:mobx/mobx.dart';

part 'home_presenter.g.dart';

class HomePresenter = HomePresenterBase with _$HomePresenter;

abstract class HomePresenterBase with Store {
  @observable
  int tapBarNavigationIndex = 0;
}
