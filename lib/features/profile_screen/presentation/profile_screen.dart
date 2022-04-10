import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/profile_screen/presentation/widgets/profile_screen_header.dart';
import 'package:rate_club/rate_club.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/common_widgets/refreshable.dart';
import 'package:rate_club/resources/header.dart';

import 'abstract_profile_screen_presenter.dart';

class ProfileScreen extends StatefulWidget {
  final MainNavigatorKeyType _mainNavigatorKey;

  const ProfileScreen({
    Key? key,
    required MainNavigatorKeyType mainNavigatorKey,
  })  : _mainNavigatorKey = mainNavigatorKey,
        super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AfterLayoutMixin {
  AbstractProfileScreenPresenter get presenter => Provider.of<AbstractProfileScreenPresenter>(context, listen: false);

  @override
  void afterFirstLayout(BuildContext context) {
    presenter.fetch();
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(AppIcons.arrow_left_line, color: AppColors.black100),
                      const SizedBox(width: 15),
                      if (presenter.profile != null) ...[
                        Flexible(
                          child: Text(
                            presenter.profile!.fullName,
                            style: AppTextStyles.semiBold16.apply(color: AppColors.black100),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
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
    final presenter = Provider.of<AbstractProfileScreenPresenter>(context);

    return Observer(
      builder: (_) {
        if (presenter.profile == null) return const SizedBox.shrink();

        final profile = presenter.profile!;

        return Refreshable(
          scrollPhysics: const AlwaysScrollableScrollPhysics(),
          onRefresh: presenter.refresh,
          slivers: const [
            SliverToBoxAdapter(
              child: ProfileScreenHeader(),
            )
          ],
        );
      },
    );
  }
}
