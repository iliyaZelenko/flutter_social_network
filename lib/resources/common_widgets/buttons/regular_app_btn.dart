import 'package:flutter/widgets.dart';

import 'abstract_app_btn.dart';

class RegularAppBtn extends AbstractAppBtn {
  const RegularAppBtn({
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
          outlined: outlined,
        );
}
