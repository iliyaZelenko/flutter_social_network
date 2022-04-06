import 'package:mobx/mobx.dart';
import 'package:rate_club/features/other_profile/domain/entities/other_profile_entity.dart';
import 'package:rate_club/features/other_profile/domain/use_cases/get_other_profile_use_case.dart';

part 'other_profile_presenter.g.dart';

class OtherProfilePresenter = OtherProfilePresenterBase with _$OtherProfilePresenter;

abstract class OtherProfilePresenterBase with Store {
  final GetOtherProfileUseCase _getOtherProfileUseCase;

  OtherProfilePresenterBase({
    required GetOtherProfileUseCase getOtherProfileUseCase,
  }) : _getOtherProfileUseCase = getOtherProfileUseCase;

  @readonly
  OtherProfileEntity? _profile;

  @readonly
  bool _loading = false;

  @action
  Future<void> fetch(String username) async {
    _loading = true;
    _profile = await _getOtherProfileUseCase.execute(username);
    _loading = false;
  }

  @action
  Future<void> refresh() async {
    _profile = await _getOtherProfileUseCase.execute(_profile!.username);
  }
}
