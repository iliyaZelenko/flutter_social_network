import 'package:flutter/cupertino.dart';

class KeyboardSpacer extends StatelessWidget {
  final bool handleSafeArea;
  final int bottomPaddingAboveKeyboard;

  const KeyboardSpacer({
    Key? key,
    this.handleSafeArea = false,
    this.bottomPaddingAboveKeyboard = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: height +
          (height != 0.0 ? bottomPaddingAboveKeyboard : 0.0) +
          (handleSafeArea && height == 0.0 ? MediaQuery.of(context).padding.bottom : 0.0),
    );
  }
}
