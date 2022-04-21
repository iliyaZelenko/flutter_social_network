import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icon_interface.dart';

// THIS FILE IS AUTO-GENERATED by rate_club/scripts/icons_generator.py

class IconSend extends StatelessWidget implements IconInterface {
  final double? height;
  final double? width;
  final double? size;
  final Color? color;

  static const _svgString = '''
	<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 21C1.8 19.4 2.83333 13.6667 4 11C8 8 16 7.99992 20 11C22.8 17.8 19.1667 20.5 17 21H7Z" fill="#CED7FA"/><path d="M7.21783 20.9384L7.1005 21.6792H7.1005L7.21783 20.9384ZM3.06156 16.7822L3.80232 16.6648L3.06156 16.7822ZM20.9384 16.7822L21.6792 16.8995V16.8995L20.9384 16.7822ZM16.7822 20.9384L16.8995 21.6792H16.8995L16.7822 20.9384ZM20.6 10.5496C20.3513 10.2184 19.8811 10.1516 19.5499 10.4003C19.2187 10.6491 19.1519 11.1192 19.4007 11.4504L20.6 10.5496ZM4.59931 11.4504C4.84808 11.1192 4.78126 10.6491 4.45007 10.4003C4.11888 10.1516 3.64873 10.2184 3.39996 10.5496L4.59931 11.4504ZM11.25 17C11.25 17.4142 11.5858 17.75 12 17.75C12.4142 17.75 12.75 17.4142 12.75 17H11.25ZM7.41232 6.53403C7.15497 6.8586 7.20946 7.33034 7.53403 7.58768C7.8586 7.84503 8.33034 7.79054 8.58768 7.46597L7.41232 6.53403ZM9.39785 5.23703L8.81016 4.77106L9.39785 5.23703ZM14.6022 5.23703L15.1898 4.77106L14.6022 5.23703ZM15.4123 7.46597C15.6697 7.79054 16.1414 7.84503 16.466 7.58768C16.7905 7.33034 16.845 6.8586 16.5877 6.53403L15.4123 7.46597ZM11.7493 3.01989L11.6313 2.27923L11.6313 2.27923L11.7493 3.01989ZM12.2507 3.01989L12.3687 2.27923L12.3687 2.27923L12.2507 3.01989ZM20.25 14V15H21.75V14H20.25ZM15 20.25H9V21.75H15V20.25ZM3.75 15V14H2.25V15H3.75ZM9 20.25C8.04233 20.25 7.65082 20.2477 7.33515 20.1977L7.1005 21.6792C7.56216 21.7523 8.09965 21.75 9 21.75V20.25ZM2.25 15C2.25 15.9003 2.24767 16.4378 2.32079 16.8995L3.80232 16.6648C3.75233 16.3492 3.75 15.9577 3.75 15H2.25ZM7.33515 20.1977C5.51661 19.9096 4.09035 18.4834 3.80232 16.6648L2.32079 16.8995C2.71048 19.3599 4.64012 21.2895 7.1005 21.6792L7.33515 20.1977ZM20.25 15C20.25 15.9577 20.2477 16.3492 20.1977 16.6648L21.6792 16.8995C21.7523 16.4378 21.75 15.9003 21.75 15H20.25ZM15 21.75C15.9003 21.75 16.4378 21.7523 16.8995 21.6792L16.6648 20.1977C16.3492 20.2477 15.9577 20.25 15 20.25V21.75ZM20.1977 16.6648C19.9096 18.4834 18.4834 19.9096 16.6648 20.1977L16.8995 21.6792C19.3599 21.2895 21.2895 19.3599 21.6792 16.8995L20.1977 16.6648ZM21.75 14C21.75 12.7064 21.3219 11.5106 20.6 10.5496L19.4007 11.4504C19.9342 12.1607 20.25 13.0424 20.25 14H21.75ZM3.75 14C3.75 13.0424 4.06583 12.1607 4.59931 11.4504L3.39996 10.5496C2.67806 11.5106 2.25 12.7064 2.25 14H3.75ZM12.75 17V4H11.25V17H12.75ZM8.58768 7.46597L9.98553 5.703L8.81016 4.77106L7.41232 6.53403L8.58768 7.46597ZM14.0145 5.703L15.4123 7.46597L16.5877 6.53403L15.1898 4.77106L14.0145 5.703ZM9.98553 5.703C10.5543 4.98568 10.9418 4.49884 11.2682 4.17113C11.5913 3.84678 11.7612 3.77747 11.8673 3.76055L11.6313 2.27923C11.0582 2.37055 10.6096 2.70685 10.2055 3.11252C9.80475 3.51484 9.35616 4.08245 8.81016 4.77106L9.98553 5.703ZM15.1898 4.77106C14.6438 4.08245 14.1953 3.51484 13.7945 3.11252C13.3904 2.70685 12.9418 2.37055 12.3687 2.27923L12.1327 3.76055C12.2388 3.77747 12.4087 3.84678 12.7318 4.17113C13.0582 4.49884 13.4457 4.98568 14.0145 5.703L15.1898 4.77106ZM11.8673 3.76055C11.9117 3.75348 11.9559 3.75 12 3.75V2.25C11.8766 2.25 11.7534 2.25978 11.6313 2.27923L11.8673 3.76055ZM12 3.75C12.0441 3.75 12.0883 3.75348 12.1327 3.76055L12.3687 2.27923C12.2466 2.25978 12.1234 2.25 12 2.25V3.75ZM12.75 4V3H11.25V4H12.75Z" fill="#5B5A69"/></svg>
    ''';

  const IconSend({Key? key, this.height, this.width, this.size, this.color}) : super(key: key);

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

    