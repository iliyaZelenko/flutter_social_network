import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_text_styles.dart';

import 'abstract_app_btn.dart';

class AppBtnBig extends AbstractAppBtn {
  const AppBtnBig({
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          // TODO Ilya: в дизайне regular16, но я не могу weight 600 поставить, поэтому так
          textStyle: AppTextStyles.regular18,
          tapped: tapped,
          child: child,
          text: text,
          color: color,
          textColor: textColor,
          onTap: onTap,
          loading: loading,
          outlined: outlined,
        );
}
