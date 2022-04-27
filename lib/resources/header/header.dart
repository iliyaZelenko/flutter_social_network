import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/resources/app_colors.dart';

class Header extends StatelessWidget {
  // TODO Ilya: Maybe? "+ screenPadding.top"
  static const double height = 64;

  final Widget? slot;

  const Header({Key? key, this.slot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        // TODO Ilya: + effectiveTopPadding
        height: height,
        child: ColoredBox(
          color: AppColors.white100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: slot == null ? const SizedBox.shrink() : slot!,
          ),
        ),
      ),
    );
  }
}
