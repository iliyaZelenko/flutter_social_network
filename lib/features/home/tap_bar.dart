import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/delays.dart';

class TapBar extends StatelessWidget {
  const TapBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePresenter = context.presenter<HomePresenter>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white100,
        boxShadow: [
          BoxShadow (
            color: AppColors.black100.withOpacity(0.1),
            offset: const Offset(0, -2),
            blurRadius: 8,
          ),
        ]
      ),
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
                  alignment: Alignment.center,
                  text: 'Лента',
                  onPressed: () => homePresenter.index.value = 0,
                ),
                TabBarBtn(
                  key: const ValueKey('invest'),
                  selected: value == 1,
                  unSelectedIcon: AppIcons.chart_bar_line,
                  selectedIcon: AppIcons.chart_bar_line,
                  alignment: Alignment.center,
                  text: 'Инвест',
                  onPressed: () => homePresenter.index.value = 1,
                ),
                TabBarBtn(
                  key: const ValueKey('create'),
                  selected: value == 2,
                  unSelectedIcon: AppIcons.add_circle_line,
                  selectedIcon: AppIcons.add_circle_fill,
                  alignment: Alignment.center,
                  text: 'Создать',
                  onPressed: () => homePresenter.index.value = 2,
                ),
                TabBarBtn(
                  key: const ValueKey('chats'),
                  selected: value == 3,
                  unSelectedIcon: AppIcons.chat_1_line,
                  selectedIcon: AppIcons.chat_1_fill,
                  alignment: Alignment.center,
                  text: 'Чаты',
                  onPressed: () => homePresenter.index.value = 3,
                ),
                TabBarBtn(
                  key: const ValueKey('subscriptions'),
                  selected: value == 4,
                  unSelectedIcon: AppIcons.user_4_line,
                  selectedIcon: AppIcons.user_4_fill,
                  alignment: Alignment.center,
                  text: 'Подписки',
                  onPressed: () => homePresenter.index.value = 4,
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
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 7),
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
                  duration: Delays.delay300,
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
