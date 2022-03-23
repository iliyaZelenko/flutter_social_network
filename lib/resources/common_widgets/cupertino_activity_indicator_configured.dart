import 'dart:io';
import 'dart:math';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:nil/nil.dart';
import 'package:rate_club/resources/delays.dart';

Widget buildRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  final double percentageComplete = (pulledExtent / refreshTriggerPullDistance).clamp(0, 1);
  return Center(
    child: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          // TODO Ilya: screenPadding.top + (Platform.isAndroid ? 18 : 6)
          top: 30 + (Platform.isAndroid ? 18 : 6),
          left: 0,
          right: 0,
          child:
              Center(child: _buildIndicatorForRefreshState(refreshState, 15, percentageComplete)),
        ),
      ],
    ),
  );
}

Widget buildRefreshIndicatorDefault(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  final double percentageComplete = (pulledExtent / refreshTriggerPullDistance).clamp(0, 1);
  return Center(
    child: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0.0,
          right: 0.0,
          child:
              Center(child: _buildIndicatorForRefreshState(refreshState, 15, percentageComplete)),
        ),
      ],
    ),
  );
}

const activityIndicator = Center(
  child: CupertinoActivityIndicator(radius: 15),
);

Widget _buildIndicatorForRefreshState(
    RefreshIndicatorMode refreshState, double radius, double percentageComplete) {
  switch (refreshState) {
    case RefreshIndicatorMode.drag:
      const Curve opacityCurve = Interval(0, 0.35, curve: Curves.easeInOut);
      if (percentageComplete < 0.1) {
        return nil;
      }
      return Opacity(
        opacity: opacityCurve.transform(percentageComplete),
        child: CupertinoActivityIndicator.partiallyRevealed(
          radius: radius,
          progress: percentageComplete,
        ),
      );
    case RefreshIndicatorMode.armed:
    case RefreshIndicatorMode.refresh:
      return Animator<double>(
        curve: Curves.easeOutQuad,
        duration: Delays.delay1sec,
        tween: Tween(begin: 0, end: pi),
        builder: (ctx, state, widget) {
          return Transform.rotate(angle: state.value, child: widget);
        },
        child: CupertinoActivityIndicator(radius: radius),
      );
    case RefreshIndicatorMode.done:
      return Transform.rotate(
        angle: pi,
        child: CupertinoActivityIndicator(radius: radius * percentageComplete),
      );
    case RefreshIndicatorMode.inactive:
      return nil;
  }
}
