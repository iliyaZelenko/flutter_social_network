import '../rate_club.dart';

mixin Delays {
  static Cancelable get defaultDelayCancelable =>
      Cancelable.fromFuture(Future.delayed(delay400));

  static Cancelable get defaultDelayCancelable500 =>
      Cancelable.fromFuture(Future.delayed(delay500));

  static Cancelable get defaultDelayCancelable600 =>
      Cancelable.fromFuture(Future.delayed(delay600));

  static Cancelable get defaultDelayCancelable1500 =>
      Cancelable.fromFuture(Future.delayed(delay500 * 3));

  static Cancelable get twoSecDelayCancelable =>
      Cancelable.fromFuture(Future.delayed(delay1sec * 2));

  static Cancelable get fiveSecDelayCancelable =>
      Cancelable.fromFuture(Future.delayed(delay1sec * 5));

  static const delay50 = Duration(milliseconds: 50);
  static const delay100 = Duration(milliseconds: 100);
  static const delay200 = Duration(milliseconds: 200);
  static const delay300 = Duration(milliseconds: 300);
  static const delay400 = Duration(milliseconds: 400);
  static const delay500 = Duration(milliseconds: 500);
  static const delay600 = Duration(milliseconds: 600);
  static const delay1sec = Duration(milliseconds: 1000);
}
