import 'package:auth/auth.dart';
import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_routes.dart';

class HomePresenter extends Presenter {
  final index = ValueNotifier(0);

  void logOut () {
    BolterProvider.of(context).dependency<AuthUseCase>(existingInstance: true).logOut();
    index.value = 0;
    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
  }
}
