import 'package:flutter/material.dart';
import 'package:our_tribe/features/settings/models/reward.dart';
import 'package:our_tribe/features/settings/views/rewards/rewards_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// One reward goal card (`.rw-card`): gift icon, name, kind tag,
/// member-colored progress bar and status line.
class RewardCard extends StatelessWidget {
  const RewardCard({super.key, required this.reward});

  final Reward reward;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RewardsController>();
    final tribeService = context.watch<TribeService>();

    final member = reward.memberId != null
        ? tribeService.memberById(reward.memberId!)
        : null;
    final barColor = member?.color ?? AppColors.memberTerracotta;
    final kindLabel = member?.name ?? l10n.tribeKind;
    final isUnlocked = controller.isUnlocked(reward);

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(AppRadii.iconPill),
            ),
            child: const AppIcon(
              AppIconData.gift,
              size: 22,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        reward.name,
                        style: AppTextStyles.taskName.copyWith(fontSize: 14.5),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.soften(barColor, 0.2),
                        borderRadius: BorderRadius.circular(
                          AppRadii.sectionIcon,
                        ),
                      ),
                      child: Text(
                        kindLabel,
                        style: AppTextStyles.meta.copyWith(
                          fontSize: 11,
                          color: AppColors.deepen(barColor, 0.15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                  child: SizedBox(
                    height: 7,
                    child: Stack(
                      children: [
                        Container(color: AppColors.lineLight),
                        AnimatedFractionallySizedBox(
                          duration: AppDurations.bars,
                          curve: AppDurations.ease,
                          alignment: Alignment.centerLeft,
                          widthFactor: controller.progressFor(reward),
                          heightFactor: 1,
                          child: Container(color: barColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (isUnlocked)
                  Row(
                    children: [
                      const AppIcon(
                        AppIconData.check,
                        size: 13,
                        color: AppColors.memberGreen,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        l10n.unlockedLabel,
                        style: AppTextStyles.meta.copyWith(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.deepen(AppColors.memberGreen, 0.2),
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    l10n.rewardCardProgress(
                      controller.weeklyTribePoints,
                      reward.goal,
                      controller.remainingFor(reward),
                    ),
                    style: AppTextStyles.meta.copyWith(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
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
