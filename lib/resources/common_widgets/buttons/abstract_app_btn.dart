import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/delays.dart';

import 'regular_app_btn.dart';
import 'regular_unconstrained_app_btn.dart';

abstract class AbstractAppBtn extends StatefulWidget {
  static const defaultColor = AppColors.purple80;

  const AbstractAppBtn({
    Key? key,
    this.tapped = false,
    this.child,
    this.text,
    this.icon,
    required this.padding,
    required this.centered,
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
  final Color color;
  final Color textColor;
  final Widget? icon;
  final EdgeInsets padding;
  final bool centered;
  final VoidCallback? onTap;
  final bool loading;
  final bool outlined;

  const factory AbstractAppBtn.regularUnconstrained({
    Key? key,
    bool tapped,
    Widget? child,
    String? text,
    Color? color,
    Color textColor,
    VoidCallback? onTap,
    bool? loading,
  }) = RegularUnconstrainedAppBtn;

  const factory AbstractAppBtn.regular({
    Key? key,
    bool tapped,
    Widget? child,
    String? text,
    Color? color,
    Color textColor,
    VoidCallback? onTap,
    bool? loading,
  }) = RegularAppBtn;

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
            style: AppTextStyles.semiBold16.apply(color: textColor),
            child: widget.text != null ? Text(widget.text!) : widget.child!,
          );

    final child = AnimatedContainer(
      alignment: widget.centered ? Alignment.center : null,
      padding: widget.loading ? const EdgeInsets.all(10) : widget.padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(32)),
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
        Future.delayed(Delays.delay100, () {
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
