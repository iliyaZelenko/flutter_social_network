import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/auth/presentation/auth_presenter.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_routes.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/assets.dart';

import 'buttons/app_btn_regular.dart';

// TODO Ilya: ValueListenable
class AppDrawerController {
  // ...and don't use final until refactor
  late void Function() open;
}

class AppDrawer extends StatefulWidget {
  final AppDrawerController controller;
  final MainNavigatorKeyType mainNavigatorKey;

  const AppDrawer({
    Key? key,
    required this.controller,
    required this.mainNavigatorKey,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final int currentYear = DateTime.now().year;
  late final GlobalKey<DrawerControllerState> _drawerKey = GlobalKey<DrawerControllerState>();

  void _open() {
    _drawerKey.currentState?.open();
  }

  void _close() {
    _drawerKey.currentState?.close();
  }

  @override
  void initState() {
    super.initState();

    widget.controller.open = _open;
  }

  @override
  Widget build(BuildContext context) {
    final authPresenter = Provider.of<AuthPresenter>(context);
    final profilePresenter = Provider.of<ProfilePresenter>(context);
    final homePresenter = Provider.of<HomePresenter>(context);
    const drawerDivider = Center(
      child: SizedBox(
        width: 180,
        child: Divider(
          thickness: 0.7,
          color: AppColors.white40,
        ),
      ),
    );

    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      child: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 21, top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Assets.logoText,
                      width: 112,
                    ),
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        _close();
                      },
                      child: const Icon(
                        AppIcons.close_line,
                        color: AppColors.black100,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),

              // Profile info
              GestureDetector(
                onTap: () {
                  _close();
                  widget.mainNavigatorKey.currentState!.pushNamed(AppRoutes.myProfile);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 21, bottom: 20),
                  child: Column(children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.white60,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(profilePresenter.profile!.avatar),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profilePresenter.profile!.fullName,
                                  style: AppTextStylesOld.semiBold15.apply(color: AppColors.black100),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '@${profilePresenter.profile!.nickname}',
                                  style: AppTextStylesOld.regular12.apply(color: AppColors.black60),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 50),
                          const Icon(AppIcons.arrow_right_line, color: AppColors.black80),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 23, right: 37),
                child: Row(
                  children: [
                    Expanded(
                      child: AppBtnRegular(
                        text: 'СОЗДАТЬ ПОСТ',
                        useMinPadding: true,
                        outlined: true,
                        onTap: () {
                          _close();
                          homePresenter.tapBarNavigationIndex = 1;
                          widget.mainNavigatorKey.currentState!
                              .popUntil((route) => route.settings.name == AppRoutes.home);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 6, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      drawerDivider,
                      // Menu items
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Observer(builder: (_) {
                              final isSelected = homePresenter.tapBarNavigationIndex == 2;

                              return ListTile(
                                title: Row(
                                  children: [
                                    Icon(
                                      isSelected ? AppIcons.home_4_fill : AppIcons.home_4_line,
                                      color: isSelected ? AppColors.purple100 : AppColors.black60,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Лента',
                                      style: AppTextStylesOld.regular15.apply(
                                        color: isSelected ? AppColors.black100 : AppColors.black80,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _close();
                                  homePresenter.tapBarNavigationIndex = 0;
                                  widget.mainNavigatorKey.currentState!
                                      .popUntil((route) => route.settings.name == AppRoutes.home);
                                },
                              );
                            }),
                            Observer(builder: (_) {
                              final isSelected = homePresenter.tapBarNavigationIndex == 1;

                              return ListTile(
                                title: Row(
                                  children: [
                                    Icon(
                                      isSelected ? AppIcons.user_4_fill : AppIcons.user_4_line,
                                      color: isSelected ? AppColors.purple100 : AppColors.black60,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Подписки',
                                      style: AppTextStylesOld.regular15.apply(
                                        color: isSelected ? AppColors.black100 : AppColors.black80,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  _close();
                                  homePresenter.tapBarNavigationIndex = 2;
                                  widget.mainNavigatorKey.currentState!
                                      .popUntil((route) => route.settings.name == AppRoutes.home);
                                },
                              );
                            }),
                            const Spacer(),
                            drawerDivider,
                            ListTile(
                              title: Row(
                                children: [
                                  const Icon(
                                    AppIcons.door_line,
                                    color: AppColors.black40,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text('Выйти', style: AppTextStylesOld.regular15.apply(color: AppColors.black80)),
                                ],
                              ),
                              onTap: () {
                                authPresenter.logOut();

                                widget.mainNavigatorKey.currentState!
                                    .pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
                              },
                            ),
                            drawerDivider,
                            Padding(
                              padding: const EdgeInsets.only(left: 22, top: 9, bottom: 9),
                              child: Text(
                                'Конфиденциальность\n'
                                'Условия использования\n'
                                'Реклама\n'
                                'Файлы cookie\n'
                                '© RateClub, ${currentYear}',
                                style: AppTextStylesOld.regular15.apply(color: AppColors.black80),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
