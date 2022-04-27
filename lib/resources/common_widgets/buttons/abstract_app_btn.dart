import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/durations.dart';
import 'package:rate_club/resources/icons/icon_interface.dart';

import 'app_btn_regular.dart';
import 'app_btn_small.dart';

abstract class AbstractAppBtn extends StatefulWidget {
  static const defaultColor = AppColors.blue80;

  const AbstractAppBtn({
    Key? key,
    this.tapped = false,
    this.child,
    this.text,
    this.textStyle,
    this.icon,
    required this.padding,
    this.onTap,
    bool? loading,
    // Fill with transparent, only border
    bool? outlined,
    Color? textColor,
    Color? color,
  })  : loading = loading ?? false,
        outlined = outlined ?? false,
        color = color ?? (outlined == true ? AppColors.transparent : defaultColor),
        textColor = textColor ?? (outlined == true ? defaultColor : AppColors.white80),
        assert((child != null && text == null) || (child == null && text != null), 'Only "child" or "text"'),
        super(key: key);

  final bool tapped;
  final Widget? child;
  final String? text;
  final TextStyle? textStyle;
  final Color color;
  final Color textColor;
  final IconInterface? icon;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final bool loading;
  final bool outlined;

  const factory AbstractAppBtn.regular({
    Key? key,
    bool tapped,
    Widget? child,
    String? text,
    Color? color,
    Color textColor,
    VoidCallback? onTap,
    bool? loading,
  }) = AppBtnRegular;

  const factory AbstractAppBtn.small({
    Key? key,
    bool tapped,
    Widget? child,
    String? text,
    Color? color,
    Color textColor,
    VoidCallback? onTap,
    bool? loading,
  }) = AppBtnSmall;

  @override
  State<AbstractAppBtn> createState() => _AbstractAppBtnState();
}

class _AbstractAppBtnState extends State<AbstractAppBtn> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final fillColor = widget.color;
    final textColor = widget.textColor;
    final borderColor = widget.outlined == true ? AbstractAppBtn.defaultColor : AppColors.transparent;

    final wrappedChild = widget.loading
        ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              color: AppColors.white100,
              strokeWidth: 2.5,
            ),
          )
        : DefaultTextStyle(
            style: AppTextStyles.regular16.apply(color: textColor),
            child: widget.text != null
                ? Flexible(
                    child: Text(
                      widget.text!,
                      textAlign: TextAlign.center,
                      style: widget.textStyle,
                    ),
                  )
                : widget.child!,
          );

    final child = AnimatedContainer(
      alignment: Alignment.center,
      padding: widget.loading ? const EdgeInsets.all(10) : widget.padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(color: borderColor),
        color: _tapped ? fillColor.withOpacity(0.5) : fillColor,
      ),
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [if (widget.icon != null) widget.icon!, wrappedChild],
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapCancel: () {
        setState(() {
          _tapped = false;
        });
      },
      onTapDown: (_) {
        setState(() {
          _tapped = true;
        });
      },
      onTapUp: (_) {
        Future.delayed(Durations.duration100, () {
          if (mounted) {
            setState(() {
              _tapped = false;
            });
          }
        });
        widget.onTap?.call();
      },
      child: child,
    );
  }
}
