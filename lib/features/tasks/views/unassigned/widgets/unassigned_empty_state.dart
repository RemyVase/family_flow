import 'package:flutter/material.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Empty state of the unassigned screen: everything has an owner
/// (`.ua-empty`).
class UnassignedEmptyState extends StatelessWidget {
  const UnassignedEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.accentSoft,
                shape: BoxShape.circle,
              ),
              child: const AppIcon(
                AppIconData.check,
                size: 26,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: AppSpacing.cardPadding),
            Text(
              l10n.unassignedEmptyTitle,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 3),
            Text(
              l10n.unassignedEmptyDetail,
              style: AppTextStyles.action.copyWith(
                color: AppColors.inkTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
