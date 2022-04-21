import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_interface.dart';

// THIS FILE IS AUTO-GENERATED by rate_club/scripts/icons_generator.py

class IconLikeOn extends StatelessWidget implements IconInterface {
  final double? height;
  final double? width;
  final double? size;
  final Color? color;

  static const _svgString = '''
	<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20.3115 4.46071C17.9773 2.08032 15.2743 3.08425 13.6007 4.14593C12.655 4.74582 11.345 4.74582 10.3993 4.14593C8.72564 3.08427 6.02272 2.08035 3.68853 4.46072C-1.85249 10.1114 7.64988 21 12 21C16.3502 21 25.8525 10.1114 20.3115 4.46071Z" fill="#5F1857" stroke="#5F1857" stroke-width="1.5" stroke-linecap="round"/></svg>
    ''';

  const IconLikeOn({Key? key, this.height, this.width, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      _svgString,
      color: color,
      height: size ?? height,
      width: size ?? width,
    );
  }
}

    