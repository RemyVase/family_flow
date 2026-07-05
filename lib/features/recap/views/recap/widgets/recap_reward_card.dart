import 'package:flutter/material.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Tribe goal card at the bottom of the summary (`.reward`).
class RecapRewardCard extends StatelessWidget {
  const RecapRewardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RecapController>();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadii.iconPill),
            ),
            child: const AppIcon(
              AppIconData.gift,
              size: 22,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.tribeGoal(RecapController.rewardName),
                  style: AppTextStyles.points.copyWith(color: AppColors.accent),
                ),
                const SizedBox(height: 9),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                  child: SizedBox(
                    height: 7,
                    child: Stack(
                      children: [
                        Container(
                          color: AppColors.accent.withValues(alpha: 0.14),
                        ),
                        AnimatedFractionallySizedBox(
                          duration: AppDurations.bars,
                          curve: AppDurations.ease,
                          alignment: Alignment.centerLeft,
                          widthFactor: controller.rewardProgress,
                          heightFactor: 1,
                          child: Container(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.rewardProgress(
                    controller.totalPoints,
                    RecapController.rewardGoal,
                    controller.rewardRemaining,
                  ),
                  style: AppTextStyles.meta.copyWith(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepen(AppColors.accent, 0.2),
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
