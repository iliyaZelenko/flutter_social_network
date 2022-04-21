import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_interface.dart';

// THIS FILE IS AUTO-GENERATED by rate_club/scripts/icons_generator.py

class IconChevronLeft extends StatelessWidget implements IconInterface {
  final double? height;
  final double? width;
  final double? size;
  final Color? color;

  static const _svgString = '''
	<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14 17L12.237 15.2527C10.8311 13.8592 10.1281 13.1625 10.0199 12.3133C9.99337 12.1053 9.99337 11.8947 10.0199 11.6867C10.1281 10.8375 10.8311 10.1408 12.237 8.74731L14 7" stroke="#5B5A69" stroke-width="1.5" stroke-linecap="round"/></svg>
    ''';

  const IconChevronLeft({Key? key, this.height, this.width, this.size, this.color}) : super(key: key);

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

    