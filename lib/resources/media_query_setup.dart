import 'dart:io';

import 'package:flutter/widgets.dart';

import 'emojis.dart';

Size? screenSize;
late EdgeInsets screenPadding;
late double effectiveTopPadding;
late double effectiveBottomPadding;

class MediaQuerySetup extends StatefulWidget {
  final Widget child;

  const MediaQuerySetup(this.child, {Key? key}) : super(key: key);

  @override
  State<MediaQuerySetup> createState() => _MediaQuerySetupState();
}

class _MediaQuerySetupState extends State<MediaQuerySetup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return screenSize == null ? const _SizePropsSetup() : widget.child;
  }
}

class _SizePropsSetup extends StatelessWidget {
  const _SizePropsSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenPadding = MediaQuery.of(context).padding;
    effectiveTopPadding = screenPadding.top + ((screenPadding.top == 0 || Platform.isAndroid) ? 12 : 0);
    effectiveBottomPadding = screenPadding.bottom + ((screenPadding.bottom == 0 || Platform.isAndroid) ? 12 : 0);
    return const Text(
      emojis,
      style: TextStyle(fontSize: 5),
      textScaleFactor: 1.0,
    );
  }
}
