import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/home/views/home/home_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Progress card: "X of N tasks done", encouragement, points inset and
/// flat progress bar.
class HomeProgressCard extends StatelessWidget {
  const HomeProgressCard({super.key});

  String _message(AppLocalizations l10n, HomeController controller) =>
      switch (controller.progressMessage) {
        HomeProgressMessage.start => l10n.progressMessageStart,
        HomeProgressMessage.keepGoing => l10n.progressMessageKeepGoing,
        HomeProgressMessage.almost => l10n.progressMessageAlmost(
          controller.remainingCount,
        ),
        HomeProgressMessage.allDone => l10n.progressMessageAllDone,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<HomeController>();

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sectionGap),
      padding: const EdgeInsets.all(AppSpacing.panelPadding + 2),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.panel),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.tasksDoneCount(
                        controller.doneCount,
                        controller.totalCount,
                      ),
                      style: AppTextStyles.headerKicker.copyWith(
                        color: AppColors.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _message(l10n, controller),
                      style: AppTextStyles.action.copyWith(
                        fontSize: 15,
                        color: AppColors.accent,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.cardPadding),
              _PointsInset(points: controller.pointsToday),
            ],
          ),
          const SizedBox(height: AppSpacing.cardPadding),
          _ProgressBar(progress: controller.progress),
        ],
      ),
    );
  }
}

class _PointsInset extends StatelessWidget {
  const _PointsInset({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
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
          Text(
            l10n.plusPoints(points),
            style: GoogleFonts.figtree(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.pointsLabel.toUpperCase(),
            style: GoogleFonts.figtree(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: AppColors.accent.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.xs),
      child: SizedBox(
        height: 6,
        child: Stack(
          children: [
            Container(color: AppColors.lineLight),
            AnimatedFractionallySizedBox(
              duration: AppDurations.progress,
              curve: AppDurations.ease,
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(AppSpacing.xs),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
