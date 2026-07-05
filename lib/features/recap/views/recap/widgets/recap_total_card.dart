import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Tribe total" card: big number + delta vs last week.
class RecapTotalCard extends StatelessWidget {
  const RecapTotalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RecapController>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.panelPadding + 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.panel),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tribeTotal,
                  style: AppTextStyles.headerKicker.copyWith(
                    color: AppColors.inkSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${controller.totalPoints}',
                      style: AppTextStyles.bigNumber.copyWith(
                        color: AppColors.deepen(AppColors.accent, 0.38),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        l10n.pointsLabel,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          color: AppColors.deepen(AppColors.accent, 0.45),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(AppRadii.input),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const AppIcon(
                      AppIconData.arrowUp,
                      size: 15,
                      color: AppColors.positiveDelta,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${RecapController.deltaVsLastWeek}',
                      style: GoogleFonts.figtree(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.positiveDelta,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.vsLastWeek.toUpperCase(),
                  style: GoogleFonts.figtree(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: AppColors.accent.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
