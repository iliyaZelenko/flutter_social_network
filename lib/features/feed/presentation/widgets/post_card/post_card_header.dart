import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardHeader extends StatelessWidget {
  const PostCardHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostEntity>(context);

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
                  backgroundImage: NetworkImage(post.creator.avatar),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.creator.username,
                    style: AppTextStyles.semiBold15.apply(color: AppColors.black100),
                  ),
                  Text(
                    'недавно',
                    style: AppTextStyles.medium12.apply(color: AppColors.black40),
                  ),
                ],
              ),
              const Spacer(),

              // TODO Ilya: refactor
              const Icon(
                AppIcons.round_fill,
                size: 6,
                color: AppColors.white40,
              ),
              const SizedBox(width: 3),
              const Icon(
                AppIcons.round_fill,
                size: 6,
                color: AppColors.white40,
              ),
              const SizedBox(width: 8),
            ],
          )
        ],
      ),
    );
  }
}
