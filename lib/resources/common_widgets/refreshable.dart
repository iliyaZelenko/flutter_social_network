import 'package:flutter/cupertino.dart';
import 'package:rate_club/resources/common_widgets/cupertino_activity_indicator_configured.dart';

class Refreshable extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget? child;
  final List<Widget>? slivers;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final double refreshIndicatorExtent;
  final double refreshTriggerPullDistance;

  const Refreshable({
    Key? key,
    required this.onRefresh,
    this.child,
    this.slivers,
    this.scrollPhysics,
    this.scrollController,
    this.refreshIndicatorExtent = 60,
    this.refreshTriggerPullDistance = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: scrollPhysics,
      controller: scrollController,
      slivers: [
        CupertinoSliverRefreshControl(
          refreshIndicatorExtent: refreshIndicatorExtent,
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          onRefresh: onRefresh,
          builder: buildRefreshIndicator,
        ),
        if (child != null) SliverToBoxAdapter(child: child),
        if (slivers != null) ...slivers!
      ],
    );
  }
}
