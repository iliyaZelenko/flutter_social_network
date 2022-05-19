import 'package:flutter/material.dart';
import 'package:rate_club/resources/app_colors.dart';

class AppInlineLoader extends StatelessWidget {
  const AppInlineLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(color: AppColors.blue60);
  }
}
