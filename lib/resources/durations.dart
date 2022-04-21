import '../rate_club.dart';

mixin Durations {
  static Cancelable get defaultDurationCancelable => Cancelable.fromFuture(Future.delayed(duration400));

  static Cancelable get defaultDurationCancelable500 => Cancelable.fromFuture(Future.delayed(duration500));

  static Cancelable get defaultDurationCancelable600 => Cancelable.fromFuture(Future.delayed(duration600));

  static Cancelable get defaultDurationCancelable1500 => Cancelable.fromFuture(Future.delayed(duration500 * 3));

  static Cancelable get twoSecDurationCancelable => Cancelable.fromFuture(Future.delayed(duration1sec * 2));

  static Cancelable get fiveSecDurationCancelable => Cancelable.fromFuture(Future.delayed(duration1sec * 5));

  static const duration50 = Duration(milliseconds: 50);
  static const duration100 = Duration(milliseconds: 100);
  static const duration200 = Duration(milliseconds: 200);
  static const duration300 = Duration(milliseconds: 300);
  static const duration400 = Duration(milliseconds: 400);
  static const duration500 = Duration(milliseconds: 500);
  static const duration600 = Duration(milliseconds: 600);
  static const duration1sec = Duration(milliseconds: 1000);
}
