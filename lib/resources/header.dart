import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_club/resources/app_colors.dart';

class Header extends StatelessWidget {
  final Widget? slot;

  const Header({Key? key, this.slot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ColoredBox(
        color: AppColors.white100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: slot == null ? const SizedBox.shrink() : slot!,
        ),
      ),
    );
  }
}
