import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/other_profile/presentation/other_profile_presenter.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';
import 'package:rate_club/resources/header.dart';

class OtherProfileScreen extends StatefulWidget {
  final String _username;
  final MainNavigatorKeyType _mainNavigatorKey;

  const OtherProfileScreen({
    Key? key,
    required String username,
    required MainNavigatorKeyType mainNavigatorKey,
  })  : _username = username,
        _mainNavigatorKey = mainNavigatorKey,
        super(key: key);

  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> with AfterLayoutMixin {
  OtherProfilePresenter get presenter => Provider.of<OtherProfilePresenter>(context, listen: false);

  @override
  void afterFirstLayout(BuildContext context) {
    presenter.fetch(widget._username);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white80,
      child: SafeArea(
        child: Column(
          children: [
            Header(
              slot: GestureDetector(
                onTap: () {
                  // TODO Ilya: use Provider, really
                  widget._mainNavigatorKey.currentState!.pop();
                },
                child: Observer(builder: (_) {
                  return Row(
                    children: [
                      const Icon(AppIcons.arrow_left_line, color: AppColors.black100),
                      const SizedBox(width: 15),
                      if (presenter.profile != null) ...[
                        Text(
                          presenter.profile!.fullName,
                          style: AppTextStyles.semiBold16.apply(color: AppColors.black100),
                        ),
                        if (presenter.profile!.isVerified) ...const [
                          SizedBox(width: 5),
                          Icon(
                            AppIcons.check_circle_fill,
                            size: 17,
                          )
                        ]
                      ]
                    ],
                  );
                }),
              ),
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  return presenter.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const _ProfileBody();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<OtherProfilePresenter>(context);

    return Observer(
      builder: (_) {
        if (presenter.profile == null) return const SizedBox.shrink();

        final profile = presenter.profile!;

        return Refreshable(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          onRefresh: presenter.refresh,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.white100,
                    border: Border(
                      top: BorderSide(width: 0.7, color: AppColors.white60),
                      bottom: BorderSide(width: 0.7, color: AppColors.white60),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(profile.avatar),
                              ),
                            ),
                            const SizedBox(width: 21),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      profile.username,
                                      style: AppTextStyles.semiBold20.apply(color: AppColors.black100),
                                    ),
                                    if (presenter.profile!.isVerified) ...const [
                                      SizedBox(width: 9),
                                      Icon(
                                        AppIcons.check_circle_fill,
                                        size: 24,
                                      )
                                    ]
                                  ],
                                ),
                                Text(
                                  // TODO Ilya: "about"
                                  profile.fullName,
                                  style: AppTextStyles.medium14.apply(color: AppColors.black60),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
