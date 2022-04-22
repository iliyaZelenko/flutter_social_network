import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/features/feed/domain/entities/post_open_by_plan_entity.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostCardContentCarousel extends StatefulWidget {
  final PostOpenByPlanEntity post;

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

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Images
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Image.network(
                widget.post.media[index].url,
                key: ValueKey('media${widget.post.media[index].id}'),
                fit: BoxFit.cover,
              );
            },
            itemCount: widget.post.media.length,
          ),

          if (widget.post.media.length > 1)
            Positioned(
              left: 10,
              bottom: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.black100.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: SmoothPageIndicator(
                    controller: _pageController, // PageController
                    count: widget.post.media.length,
                    effect: const ScrollingDotsEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      activeDotColor: AppColors.black60,
                      dotColor: AppColors.white20,
                      activeDotScale: 1.5,
                    ), // your preferred effect
                    onDotClicked: (index) {},
                  ),
                ),
              ),
            ),

          // Counter
          if (widget.post.media.length > 1)
            Positioned(
              top: 10,
              right: 10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.black100.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '${_currentPageIndex + 1}/${widget.post.media.length}',
                    style: AppTextStyles.medium13.apply(color: AppColors.white100),
                  ),
                ),
              ),
            ),

          // Arrow left
          if (_currentPageIndex != 0)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _pageController.previousPage(duration: Durations.duration300, curve: Curves.easeInOut);
                },
                child: const SizedBox(
                  width: 120,
                  height: double.infinity,
                ),
              ),
            ),

          // Arrow right
          if (_currentPageIndex != widget.post.media.length - 1)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _pageController.nextPage(duration: Durations.duration300, curve: Curves.easeInOut);
                },
                child: const SizedBox(
                  width: 120,
                  height: double.infinity,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
