import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/settings/views/rewards/rewards_controller.dart';
import 'package:our_tribe/features/settings/views/rewards/widgets/reward_card.dart';
import 'package:our_tribe/features/settings/views/rewards/widgets/weekly_pot_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Rewards settings screen: weekly pot + reward goals.
class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardsController(),
      child: const _RewardsBody(),
    );
  }
}

class _RewardsBody extends StatelessWidget {
  const _RewardsBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RewardsController>();

    return Scaffold(
      body: TribeBackground(
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenHorizontal,
                  AppSpacing.lg,
                  AppSpacing.screenHorizontal,
                  AppSpacing.stickyActionClearance,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenHeader(
                      title: l10n.rewardsTitle,
                      subtitle: l10n.rewardsSubtitle,
                    ),
                    const WeeklyPotCard(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.goalsLabel(controller.rewards.length)),
                    const SizedBox(height: AppSpacing.sm),
                    for (final reward in controller.rewards)
                      RewardCard(reward: reward),
                    const SizedBox(height: 3),
                    const _AddRewardButton(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: StickyActionBar(
                child: PrimaryButton(
                  label: l10n.doneButton,
                  leadingIcon: AppIconData.check,
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddRewardButton extends StatelessWidget {
  const _AddRewardButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.button),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppIcon(AppIconData.plus, size: 18),
          const SizedBox(width: 7),
          Text(
            l10n.addRewardButton,
            style: AppTextStyles.action.copyWith(fontSize: 14.5),
          ),
        ],
      ),
    );
  }
}
