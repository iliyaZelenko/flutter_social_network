import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';

import 'abstract_app_btn.dart';

class AppBtnSmall extends AbstractAppBtn {
  const AppBtnSmall({
    Key? key,
    bool tapped = false,
    Widget? child,
    String? text,
    Color? color,
    Color? textColor,
    VoidCallback? onTap,
    bool? loading,
    bool? outlined,
  }) : super(
          key: key,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          textStyle: AppTextStyles.regular13,
          tapped: tapped,
          child: child,
          text: text,
          color: color ?? AppColors.blue60,
          textColor: textColor ?? AppColors.black80,
          onTap: onTap,
          loading: loading,
          outlined: outlined,
        );
}
