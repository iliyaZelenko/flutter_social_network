import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/home/presentation/home_presenter.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class AppDrawerController {
  late final void Function() open;
}

class AppDrawer extends StatefulWidget {
  final AppDrawerController controller;

  const AppDrawer({Key? key, required this.controller}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final GlobalKey<DrawerControllerState> _drawerKey =
      GlobalKey<DrawerControllerState>();

  void _open() {
    _drawerKey.currentState?.open();
  }

  @override
  void initState() {
    widget.controller.open = _open;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homePresenter = Provider.of<HomePresenter>(context);
    final profilePresenter = Provider.of<ProfilePresenter>(context);

    return DrawerController(
      key: _drawerKey,
      alignment: DrawerAlignment.start,
      child: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color.fromARGB(100, 125, 186, 224),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  profilePresenter.profile!.avatar),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profilePresenter.profile!.username,
                                style: AppTextStyles.semiBold15
                                    .apply(color: AppColors.black100),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                profilePresenter.profile!.fullName,
                                style: AppTextStyles.regular12
                                    .apply(color: AppColors.black60),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          const Icon(AppIconsArrow.right_open,
                              color: AppColors.black80),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    OutlinedButton(
                      onPressed: () => {},
                      child: const Text(
                        "Создать Пост",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.blue,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Divider(
                  thickness: 0.7,
                  color: AppColors.white40,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          const Icon(
                            AppIcons.home_4_fill,
                            color: AppColors.purple80,
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Лента',
                            style: AppTextStyles.medium15
                                .apply(color: AppColors.black100),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Row(
                        children: const [
                          Icon(
                            AppIcons.star_line,
                            color: AppColors.black60,
                            size: 30,
                          ),
                          SizedBox(width: 10),
                          Text('Рекомендации', style: AppTextStyles.regular15),
                        ],
                      ),
                      onTap: () {},
                    ),
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
                        homePresenter.logOut();
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
