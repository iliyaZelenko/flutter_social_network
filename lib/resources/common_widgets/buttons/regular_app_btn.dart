import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_colors.dart';

import 'abstract_app_btn.dart';

class RegularAppBtn extends AbstractAppBtn {
  const RegularAppBtn({
    Key? key,
    bool useMinPadding = false,
    bool tapped = false,
    Widget? child,
    String? text,
    Color? color,
    Color textColor = AppColors.white80,
    VoidCallback? onTap,
    bool? loading,
  }) : super(
          key: key,
          tapped: tapped,
          child: child,
          text: text,
          color: color,
          textColor: textColor,
          padding: useMinPadding
              ? const EdgeInsets.symmetric(horizontal: 19, vertical: 11)
              : const EdgeInsets.symmetric(horizontal: 65, vertical: 11),
          centered: false,
          onTap: onTap,
          loading: loading,
        );
}
