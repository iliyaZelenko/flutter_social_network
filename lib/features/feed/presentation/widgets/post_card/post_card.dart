import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/resources/app_colors.dart';

import 'post_card_content.dart';
import 'post_card_footer.dart';
import 'post_card_header.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;

  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: (post is PostOpenByPlanEntity) ? AppColors.white100 : AppColors.purple20,
          border: const Border(
            top: BorderSide(width: 0.7, color: AppColors.white60),
            bottom: BorderSide(width: 0.7, color: AppColors.white60),
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
            ),
          ],
        ),
        child: Provider<PostEntity>(
          create: (_) => post,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PostCardHeader(),
              const PostCardContent(),
              if (post is PostOpenByPlanEntity) const PostCardFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
