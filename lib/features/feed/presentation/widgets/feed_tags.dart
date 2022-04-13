import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

class FeedTags extends StatefulWidget {
  const FeedTags({Key? key}) : super(key: key);

  @override
  State<FeedTags> createState() => _FeedTagsState();
}

class _FeedTagsState extends State<FeedTags> {
  final Set<String> tags = {'Name', 'Pictures', 'Clubs_and_Cultures', 'Cars', 'Food', 'Trips', 'Sport', 'Games'};
  late String selectedTag = tags.elementAt(2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags.elementAt(index);

          return Padding(
            key: ValueKey('tag_${tag}'),
            padding: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTag = tag;
                });
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: tag == selectedTag ? AppColors.purple80 : AppColors.white100,
                  border: Border.all(width: 0.7, color: AppColors.white60),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    '#$tag',
                    style: AppTextStyles.medium14.apply(
                      color: tag == selectedTag ? AppColors.white100 : AppColors.black100,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
