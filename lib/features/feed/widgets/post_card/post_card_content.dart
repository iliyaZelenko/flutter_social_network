import 'package:feed/feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class PostCardContent extends StatelessWidget {
  final PostEntity post;

  const PostCardContent({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Text(post.content),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.network(
                    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
                  ).image,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
