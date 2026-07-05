import 'package:flutter/material.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Large choice card of the "your tribe" step (`.ob-choice`).
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.detail,
    required this.onTap,
    this.iconColor = AppColors.sky,
    this.iconBackground = AppColors.skySoft,
    this.isAccented = false,
  });

  final AppIconData icon;
  final String title;
  final String detail;
  final VoidCallback onTap;
  final Color iconColor;
  final Color iconBackground;

  /// Accented variant: accent border + soft accent background.
  final bool isAccented;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 11),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isAccented
              ? AppColors.soften(AppColors.accent, 0.08)
              : AppColors.surface,
          border: Border.all(
            color: isAccented ? AppColors.accent : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isAccented
                    ? AppColors.soften(AppColors.accent, 0.16)
                    : iconBackground,
                borderRadius: BorderRadius.circular(AppRadii.iconPill),
              ),
              child: AppIcon(
                icon,
                size: 23,
                color: isAccented ? AppColors.accent : iconColor,
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    detail,
                    style: AppTextStyles.note.copyWith(
                      color: AppColors.inkTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AppIcon(
              AppIconData.arrowRight,
              size: 18,
              color: isAccented ? AppColors.accent : AppColors.inkTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
