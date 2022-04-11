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
  final GlobalKey<DrawerControllerState> _drawerKey = GlobalKey<DrawerControllerState>();

  void _open() {
    _drawerKey.currentState?.open();
  }

  void _close() {
    _drawerKey.currentState?.close();
  }

  @override
  void initState() {
    widget.controller.open = _open;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authPresenter = Provider.of<AuthPresenter>(context);
    final profilePresenter = Provider.of<ProfilePresenter>(context);
    final homePresenter = Provider.of<HomePresenter>(context);

    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      child: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile info
              GestureDetector(
                onTap: () {
                  _close();
                  widget.mainNavigatorKey.currentState!.pushNamed(AppRoutes.myProfile);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profilePresenter.profile!.fullName,
                                style: AppTextStyles.semiBold15.apply(color: AppColors.black100),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '@${profilePresenter.profile!.username}',
                                style: AppTextStyles.regular12.apply(color: AppColors.black60),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          const Icon(AppIcons.arrow_right_line, color: AppColors.black80),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),

              // Divider
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Divider(
                  thickness: 0.7,
                  color: AppColors.white40,
                ),
              ),

              // Menu items
              Expanded(
                child: ListView(
                  children: [
                    Observer(builder: (_) {
                      final isSelected = homePresenter.tapBarNavigationIndex == 0;

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
                              style: AppTextStyles.medium15.apply(color: AppColors.black100),
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
                      final isSelected = homePresenter.tapBarNavigationIndex == 2;

                      return ListTile(
                        title: Row(
                          children: [
                            Icon(
                              isSelected ? AppIcons.user_4_fill : AppIcons.user_4_line,
                              color: isSelected ? AppColors.purple100 : AppColors.black60,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text('Подписки', style: AppTextStyles.regular15.apply(color: AppColors.black100)),
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
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(
                            AppIcons.door_line,
                            color: AppColors.black60,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text('Выйти', style: AppTextStyles.regular15),
                        ],
                      ),
                      onTap: () {
                        authPresenter.logOut();

                        widget.mainNavigatorKey.currentState!.pushNamedAndRemoveUntil(AppRoutes.auth, (_) => false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
