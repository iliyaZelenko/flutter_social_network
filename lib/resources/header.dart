import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';

class Header extends StatelessWidget {
  final Widget? slot;

  const Header({Key? key, this.slot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ColoredBox(
        color: AppColors.white100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              if (slot != null) slot!,
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
                      child: DecoratedBox(
                          decoration: BoxDecoration(
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
