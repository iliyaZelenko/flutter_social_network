import 'package:bolter_flutter/bolter_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/core/core_presenter.dart';
import 'package:rate_club/features/home/home_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final corePresenter = context.presenter<CorePresenter>();
    final homePresenter = context.presenter<HomePresenter>();

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ColoredBox(
        color: AppColors.white100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // homePresenter.logOut();
                },
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 50,
                    // backgroundImage: NetworkImage(corePresenter.profile!.avatar),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'Лента',
                style: AppTextStyles.semiBold16.apply(color: AppColors.black100),
              ),
              const Spacer(),
              const Icon(
                AppIcons.search_line,
                color: AppColors.black60,
                size: 30,
              ),
              const SizedBox(width: 20),
              // Bell with indicator
              Stack(
                children: const [
                  Positioned(
                    right: 1,
                    child: SizedBox(
                      width: 8,
                      height: 8,
                      child: DecoratedBox(decoration: BoxDecoration(
                        color: AppColors.red100,
                        shape: BoxShape.circle,
                      )),
                    ),
                  ),
                  Icon(
                    AppIcons.notification_line,
                    color: AppColors.black60,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
