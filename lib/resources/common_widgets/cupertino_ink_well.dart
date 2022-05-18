import 'package:flutter/cupertino.dart';
import 'package:rate_club/resources/app_colors.dart';

class CupertinoInkWell extends StatefulWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color highLight;
  final Color originalColor;
  final Widget child;

  const CupertinoInkWell({
    Key? key,
    this.onPressed,
    this.borderRadius = 0,
    this.highLight = CupertinoColors.systemFill,
    this.originalColor = AppColors.transparent,
    required this.child,
  }) : super(key: key);

  @override
  _CupertinoInkWellState createState() => _CupertinoInkWellState();
}

class _CupertinoInkWellState extends State<CupertinoInkWell> {
  late bool _tapped;

  @override
  void initState() {
    super.initState();
    _tapped = false;
  }

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        color: _tapped ? widget.highLight : widget.originalColor,
      ),
      duration: _tapped ? Duration.zero : const Duration(milliseconds: 200),
      curve: Curves.decelerate,
      child: widget.child,
    );

    return widget.onPressed != null
        ? GestureDetector(
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
              Future.delayed(const Duration(milliseconds: 16), () {
                if (mounted) {
                  setState(() {
                    _tapped = false;
                  });
                }
              });
              widget.onPressed!.call();
            },
            child: content,
          )
        : content;
  }
}
