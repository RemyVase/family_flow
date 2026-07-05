import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/home/views/home/home_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Ochre banner "N tâches à répartir" opening the unassigned screen
/// (`.ua-banner`). Hidden when everything is assigned.
class UnassignedBanner extends StatelessWidget {
  const UnassignedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final count = context.watch<HomeController>().unassignedCount;
    if (count == 0) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => context.push(AppRoute.tasksUnassigned.path),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sectionGap),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: AppColors.ochreSoft,
          border: Border.all(color: AppColors.soften(AppColors.ochre, 0.26)),
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadii.photo),
              ),
              child: const AppIcon(
                AppIconData.users,
                size: 20,
                color: AppColors.ochre,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.unassignedBannerTitle(count),
                    style: AppTextStyles.sectionTitle.copyWith(
                      color: AppColors.deepen(AppColors.ochre, 0.2),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.unassignedBannerSubtitle,
                    style: AppTextStyles.note.copyWith(
                      fontSize: 12,
                      color: AppColors.inkTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              constraints: const BoxConstraints(minWidth: 22),
              height: 22,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.ochre,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Text(
                '$count',
                style: GoogleFonts.figtree(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const AppIcon(
              AppIconData.chevronRight,
              size: 18,
              color: AppColors.ochre,
            ),
          ],
        ),
      ),
    );
  }
}
