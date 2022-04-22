import 'dart:io';
import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:nil/nil.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/media_query_setup.dart';

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
      children: [
        Positioned(
          top: screenPadding.top + (Platform.isAndroid ? 18 : 6),
          left: 0,
          right: 0,
          child: Center(
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                AppColors.purple100,
                BlendMode.srcATop,
              ),
              child: _buildIndicatorForRefreshState(refreshState, 15, percentageComplete),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildIndicatorForRefreshState(RefreshIndicatorMode refreshState, double radius, double percentageComplete) {
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
        duration: Durations.duration1sec,
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
