import 'package:flutter/material.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';

/// Sticky bottom action area with the background fade of the design
/// (`.dt-action`). Place inside a [Stack], aligned to the bottom.
class StickyActionBar extends StatelessWidget {
  const StickyActionBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.34],
          colors: [Color(0x00FBFAF6), AppColors.background],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.cardPadding,
          AppSpacing.screenHorizontal,
          bottomInset + AppSpacing.xxl,
        ),
        child: child,
      ),
    );
  }
}
