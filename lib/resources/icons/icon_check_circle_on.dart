import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_interface.dart';

// THIS FILE IS AUTO-GENERATED by rate_club/scripts/icons_generator.py

class IconCheckCircleOn extends StatelessWidget implements IconInterface {
  final double? height;
  final double? width;
  final double? size;
  final Color? color;

  static const _svgString = '''
	<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z" fill="#CED7FA"/><path d="M17 9L13.6308 12.7632C12.2957 14.2544 11.6282 15 10.75 15C9.8718 15 9.20425 14.2544 7.86917 12.7632L7 11.7924M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12Z" stroke="#5B5A69" stroke-width="1.5" stroke-linecap="round"/></svg>
    ''';

  const IconCheckCircleOn({Key? key, this.height, this.width, this.size, this.color}) : super(key: key);

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

    