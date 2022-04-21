import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';

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
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 55,
          child: Observer(
            builder: (_) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBarBtn(
                    key: const ValueKey('home'),
                    selected: homePresenter.tapBarNavigationIndex == 0,
                    unSelectedIcon: AppIcons.home_4_line,
                    selectedIcon: AppIcons.home_4_fill,
                    alignment: Alignment.center,
                    text: 'Лента',
                    onPressed: () => homePresenter.tapBarNavigationIndex = 0,
                  ),
                  TabBarBtn(
                    key: const ValueKey('create'),
                    selected: homePresenter.tapBarNavigationIndex == 1,
                    unSelectedIcon: AppIcons.add_circle_line,
                    selectedIcon: AppIcons.add_circle_fill,
                    alignment: Alignment.center,
                    text: 'Создать',
                    onPressed: () => homePresenter.tapBarNavigationIndex = 1,
                  ),
                  TabBarBtn(
                    key: const ValueKey('subscriptions'),
                    selected: homePresenter.tapBarNavigationIndex == 2,
                    unSelectedIcon: AppIcons.user_4_line,
                    selectedIcon: AppIcons.user_4_fill,
                    alignment: Alignment.center,
                    text: 'Подписки',
                    onPressed: () => homePresenter.tapBarNavigationIndex = 2,
                  ),
                ],
              );
            },
          ),
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
  final String text;

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
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 6),
          child: Align(
            alignment: alignment,
            child: Column(
              children: [
                AnimatedCrossFade(
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
                  duration: Durations.duration300,
                  firstCurve: Curves.decelerate.flipped,
                  secondCurve: Curves.decelerate,
                ),
                const SizedBox(height: 2),
                Text(
                  text.toUpperCase(),
                  style: AppTextStyles.regular9.apply(color: AppColors.black40),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
