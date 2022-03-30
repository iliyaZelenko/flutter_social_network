import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/feed/domain/entities/post_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_icons.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/delays.dart';

class PostCardContentCarousel extends StatefulWidget {
  final PostEntity post;

  const PostCardContentCarousel({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostCardContentCarousel> createState() => _PostCardContentCarouselState();
}

class _PostCardContentCarouselState extends State<PostCardContentCarousel> {
  late final PageController _pageController = PageController(initialPage: 0);

  int _currentPageIndex = 0;

  _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.post.media[index].url,
                    fit: BoxFit.cover,
                  );
                },
                itemCount: widget.post.media.length,
              ),
            ),
            if (widget.post.media.length > 1)
              Positioned(
                child: DecoratedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      '${_currentPageIndex + 1}/${widget.post.media.length}',
                      style: AppTextStyles.medium14.apply(color: AppColors.white100),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black100.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                top: 10,
                right: 10,
              ),
            if (_currentPageIndex != 0)
              Positioned(
                child: MaterialButton(
                  height: 24,
                  minWidth: 24,
                  onPressed: () {
                    _pageController.previousPage(duration: Delays.delay300, curve: Curves.easeInOut);
                  },
                  color: AppColors.white100,
                  textColor: Colors.white,
                  child: const Icon(
                    AppIcons.arrow_left_line,
                    color: AppColors.black100,
                    size: 20,
                  ),
                  shape: const CircleBorder(),
                ),
                left: -5,
              ),
            if (_currentPageIndex != widget.post.media.length - 1)
              Positioned(
              child: MaterialButton(
                height: 24,
                minWidth: 24,
                onPressed: () {
                  _pageController.nextPage(duration: Delays.delay300, curve: Curves.easeInOut);
                },
                color: AppColors.white100,
                textColor: Colors.white,
                child: const Icon(
                  AppIcons.arrow_right_line,
                  color: AppColors.black100,
                  size: 20,
                ),
                shape: const CircleBorder(),
              ),
              right: -5,
            ),
          ],
        ),
      ),
    );
  }
}
