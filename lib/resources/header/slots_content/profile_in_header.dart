import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/profile/presentation/profile_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/common_widgets/app_drawer.dart';

// Avatar with the bell indicator
class ProfileInHeader extends StatelessWidget {
  const ProfileInHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profilePresenter = Provider.of<ProfilePresenter>(context);
    final drawerController = Provider.of<AppDrawerController>(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            drawerController.open();
          },
          child: SizedBox(
            width: 32,
            height: 32,
            child: CircleAvatar(
              radius: 200,
              backgroundImage: NetworkImage(profilePresenter.profile!.avatar),
            ),
          ),
        ),
        // Red dot
        Positioned(
          top: -5,
          right: -5,
          child: SizedBox(
            width: 16,
            height: 16,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 109, 28, 1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white100,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
