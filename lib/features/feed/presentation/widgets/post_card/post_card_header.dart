import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardHeader extends StatelessWidget {
  final PostEntity post;

  const PostCardHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 5, top: 17.5, bottom: 5),
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
              Text(
                post.creator.username,
                style: AppTextStyles.semiBold15.apply(color: AppColors.black100),
              ),
            ],
          )
        ],
      ),
    );
  }
}