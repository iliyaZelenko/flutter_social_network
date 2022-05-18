import 'package:flutter/material.dart';
import 'package:rate_club/resources/app_colors.dart';
import 'package:rate_club/resources/icons/icon_x.dart';

Future<T?> showAppDialog<T>({
  required BuildContext context,
  required Widget child,
}) {
  return showDialog<T>(
    context: context,
    builder: (ctx) => _Dialog(child),
  );
}

class _Dialog extends StatelessWidget {
  Widget child;

  _Dialog(this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const IconX(
                  color: AppColors.white100,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
