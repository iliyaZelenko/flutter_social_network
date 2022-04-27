import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/profile_screen/presentation/abstract_profile_screen_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/icons/icon_card.dart';
import 'package:rate_club/resources/icons/icon_interface.dart';
import 'package:rate_club/resources/icons/icon_person_feed.dart';
import 'package:rate_club/resources/icons/icon_profile.dart';
import 'package:rate_club/resources/icons/icon_statistics.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileScreenPresenter = Provider.of<AbstractProfileScreenPresenter>(context);

    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Btn(
              key: const ValueKey('profileContent'),
              selected: profileScreenPresenter.currentTab == 0,
              unSelectedIcon: const IconPersonFeed(),
              selectedIcon: const IconPersonFeed(),
              alignment: Alignment.center,
              text: 'content',
              onPressed: () => profileScreenPresenter.currentTab = 0,
            ),
            _Btn(
              key: const ValueKey('profileStatistics'),
              selected: profileScreenPresenter.currentTab == 1,
              unSelectedIcon: const IconStatistics(),
              selectedIcon: const IconStatistics(),
              alignment: Alignment.center,
              text: 'statistics',
              onPressed: () => profileScreenPresenter.currentTab = 1,
            ),
            _Btn(
              key: const ValueKey('profileMoney'),
              selected: profileScreenPresenter.currentTab == 2,
              unSelectedIcon: const IconCard(),
              selectedIcon: const IconCard(),
              alignment: Alignment.center,
              text: 'money',
              onPressed: () => profileScreenPresenter.currentTab = 2,
            ),
            _Btn(
              key: const ValueKey('profileAbout'),
              selected: profileScreenPresenter.currentTab == 3,
              unSelectedIcon: const IconProfile(),
              selectedIcon: const IconProfile(),
              alignment: Alignment.center,
              text: 'about',
              onPressed: () => profileScreenPresenter.currentTab = 3,
            ),
          ],
        );
      },
    );
  }
}

class _Btn extends StatelessWidget {
  final bool selected;
  final IconInterface selectedIcon;
  final IconInterface unSelectedIcon;
  final VoidCallback onPressed;
  final Alignment alignment;
  final String text;

  static const double selectedLineHeight = 2;

  const _Btn({
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Align(
            alignment: alignment,
            child: Column(
              children: [
                AnimatedCrossFade(
                  alignment: Alignment.center,
                  crossFadeState: selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild: selectedIcon,
                  secondChild: unSelectedIcon,
                  duration: Durations.duration300,
                  firstCurve: Curves.decelerate.flipped,
                  secondCurve: Curves.decelerate,
                ),
                const SizedBox(height: 3),
                Text(
                  text,
                  style: AppTextStyles.regular15.apply(color: selected ? AppColors.black100 : AppColors.black80),
                ),
                const SizedBox(height: 16),
                AnimatedSize(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: selected ? 76 : 0,
                    height: selectedLineHeight,
                    child: const ColoredBox(color: AppColors.black100),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
