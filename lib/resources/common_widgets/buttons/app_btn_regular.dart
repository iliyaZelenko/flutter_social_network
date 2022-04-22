import 'package:flutter/widgets.dart';

import 'abstract_app_btn.dart';

class AppBtnRegular extends AbstractAppBtn {
  const AppBtnRegular({
    Key? key,
    bool useMinPadding = false,
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
          padding: useMinPadding
              ? const EdgeInsets.symmetric(horizontal: 19, vertical: 11)
              : const EdgeInsets.symmetric(horizontal: 65, vertical: 11),
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
