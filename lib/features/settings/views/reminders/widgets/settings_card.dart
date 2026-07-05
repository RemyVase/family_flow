import 'package:flutter/material.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';

/// Surface card grouping setting rows, with hairline dividers
/// (`.set-card` / `.set-div`).
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        children: [
          for (final (index, child) in children.indexed) ...[
            if (index > 0)
              const Divider(
                height: 1,
                color: AppColors.lineLight,
                indent: AppSpacing.cardPadding,
                endIndent: AppSpacing.cardPadding,
              ),
            child,
          ],
        ],
      ),
    );
  }
}
