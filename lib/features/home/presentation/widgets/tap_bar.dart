import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/icons/icon_content.dart';
import 'package:rate_club/resources/icons/icon_interface.dart';
import 'package:rate_club/resources/icons/icon_money.dart';
import 'package:rate_club/resources/icons/icon_people.dart';
import 'package:rate_club/resources/media_query_setup.dart';

final double tabBarHeight = 64 + screenPadding.bottom;

class TapBar extends StatelessWidget {
  const TapBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePresenter = Provider.of<HomePresenter>(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white100,
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SizedBox(
        height: tabBarHeight,
        child: Observer(
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabBarBtn(
                  key: const ValueKey('marketplace'),
                  selected: homePresenter.tapBarNavigationIndex == 0,
                  unSelectedIcon: const IconMoney(),
                  selectedIcon: const IconMoney(),
                  alignment: Alignment.center,
                  text: 'marketplace',
                  onPressed: () => homePresenter.tapBarNavigationIndex = 0,
                ),
                TabBarBtn(
                  key: const ValueKey('people'),
                  selected: homePresenter.tapBarNavigationIndex == 1,
                  unSelectedIcon: const IconPeople(),
                  selectedIcon: const IconPeople(),
                  alignment: Alignment.center,
                  text: 'people',
                  onPressed: () => homePresenter.tapBarNavigationIndex = 1,
                ),
                TabBarBtn(
                  key: const ValueKey('content'),
                  selected: homePresenter.tapBarNavigationIndex == 2,
                  unSelectedIcon: const IconContent(),
                  selectedIcon: const IconContent(),
                  alignment: Alignment.center,
                  text: 'content',
                  onPressed: () => homePresenter.tapBarNavigationIndex = 2,
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
  final IconInterface selectedIcon;
  final IconInterface unSelectedIcon;
  final VoidCallback onPressed;
  final Alignment alignment;
  final String text;

  static const double selectedLineHeight = 2;

  const TabBarBtn({
    Key? key,
    required this.selected,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.onPressed,
    required this.alignment,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Align(
            alignment: alignment,
            child: Column(
              children: [
                AnimatedSize(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: selected ? 76 : 0,
                    height: selectedLineHeight,
                    child: const ColoredBox(color: AppColors.black100),
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedCrossFade(
                  alignment: Alignment.center,
                  crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild: selectedIcon,
                  secondChild: unSelectedIcon,
                  duration: Durations.duration300,
                  firstCurve: Curves.decelerate.flipped,
                  secondCurve: Curves.decelerate,
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: AppTextStyles.regular13.apply(color: selected ? AppColors.black100 : AppColors.black80),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
