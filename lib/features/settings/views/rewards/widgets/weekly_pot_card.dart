import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/settings/views/rewards/rewards_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Cagnotte de la semaine" panel at the top of the rewards screen.
class WeeklyPotCard extends StatelessWidget {
  const WeeklyPotCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RewardsController>();

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
                  l10n.weeklyPotLabel,
                  style: AppTextStyles.headerKicker.copyWith(
                    color: AppColors.inkSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${controller.weeklyTribePoints}',
                      style: GoogleFonts.figtree(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        color: AppColors.deepen(AppColors.accent, 0.38),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        l10n.tribePointsLabel,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 15,
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
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppRadii.iconPill),
            ),
            child: AppIcon(
              AppIconData.gift,
              size: 26,
              color: AppColors.deepen(AppColors.accent, 0.25),
            ),
          ),
        ],
      ),
    );
  }
}
