import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/delays.dart';

class TapBar extends StatelessWidget {
  const TapBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePresenter = context.presenter<HomePresenter>();

    return ColoredBox(
      color: AppColors.white100,
      child: SizedBox(
        height: 55,
        child: ValueListenableBuilder<int>(
          valueListenable: homePresenter.index,
          builder: (ctx, value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabBarBtn(
                  key: const ValueKey('home'),
                  selected: value == 0,
                  unSelectedIcon: AppIcons.home_4_line,
                  selectedIcon: AppIcons.home_4_fill,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 5, left: 20),
                  onPressed: () => homePresenter.index.value = 0,
                ),
                TabBarBtn(
                  key: const ValueKey('invest'),
                  selected: value == 1,
                  unSelectedIcon: AppIcons.chart_bar_line,
                  selectedIcon: AppIcons.chart_bar_line,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 5),
                  onPressed: () => homePresenter.index.value = 1,
                ),
                TabBarBtn(
                  key: const ValueKey('invest test'),
                  selected: value == 2,
                  unSelectedIcon: AppIcons.airplay_line,
                  selectedIcon: AppIcons.airplay_line,
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.only(top: 5, right: 20),
                  onPressed: () => homePresenter.index.value = 0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TabBarBtn extends StatelessWidget {
  final bool selected;
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final VoidCallback onPressed;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;

  const TabBarBtn({
    Key? key,
    required this.selected,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.onPressed,
    required this.alignment,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Padding(
          padding: padding,
          child: Align(
            alignment: alignment,
            child: AnimatedCrossFade(
              alignment: Alignment.center,
              crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: Icon(
                selectedIcon,
                color: AppColors.purple100,
                size: 30,
              ),
              secondChild: Icon(
                unSelectedIcon,
                color: AppColors.black60,
                size: 30,
              ),
              duration: Delays.delay300,
              firstCurve: Curves.decelerate.flipped,
              secondCurve: Curves.decelerate,
            ),
          ),
        ),
      ),
    );
  }
}
