import 'package:flutter/material.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Small bordered note card with an optional leading icon (`.ob-note`).
class OnboardingNote extends StatelessWidget {
  const OnboardingNote({super.key, required this.text, this.icon});

  final String text;
  final AppIconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.input),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            AppIcon(icon!, size: 15, color: AppColors.accent),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(child: Text(text, style: AppTextStyles.note)),
        ],
      ),
    );
  }
}
