import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/app_text_styles.dart';
import 'package:rate_club/resources/delays.dart';
import 'regular_app_btn.dart';
import 'regular_unconstrained_app_btn.dart';

abstract class AbstractAppBtn extends StatefulWidget {
  const AbstractAppBtn({
    Key? key,
    this.tapped = false,
    this.child,
    this.text,
    this.color,
    this.textColor = AppColors.white80,
    this.icon,
    required this.padding,
    required this.centered,
    this.onTap,
    bool? loading,
  })  : loading = loading ?? false,
        assert((child != null && text == null) || (child == null && text != null), 'Only "child" or "text"'),
        super(key: key);

  final bool tapped;
  final Widget? child;
  final String? text;
  final Color? color;
  final Color textColor;
  final Widget? icon;
  final EdgeInsets padding;
  final bool centered;
  final VoidCallback? onTap;
  final bool loading;

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
  static const defaultColor = AppColors.purple80;

  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    final wrappedChild = widget.loading
        ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(color: AppColors.white100, strokeWidth: 2.5,),
          )
        : DefaultTextStyle(
            style: AppTextStyles.semiBold16.apply(color: widget.textColor),
            child: widget.text != null ? Text(widget.text!) : widget.child!,
          );

    final child = AnimatedContainer(
      alignment: widget.centered ? Alignment.center : null,
      padding: widget.loading ? const EdgeInsets.all(10) : widget.padding,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        color: widget.color == null
            ? (_tapped ? defaultColor.withOpacity(0.5) : defaultColor)
            : (_tapped ? widget.color!.withOpacity(0.5) : widget.color),
      ),
      duration: const Duration(milliseconds: 200),
      curve: Curves.decelerate,
      child: widget.icon != null
          ? Row(
              children: [widget.icon!, wrappedChild],
            )
          : wrappedChild,
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