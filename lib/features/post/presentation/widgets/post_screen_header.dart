import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/post/presentation/post_presenter.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostScreenHeader extends StatelessWidget {
  const PostScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postPresenter = Provider.of<PostPresenter>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 5, top: 17.5, bottom: 12.5),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(postPresenter.post!.creator.avatar),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                postPresenter.post!.creator.nickname,
                style: AppTextStyles.semiBold15.apply(color: AppColors.black100),
              ),
            ],
          )
        ],
      ),
    );
  }
}
