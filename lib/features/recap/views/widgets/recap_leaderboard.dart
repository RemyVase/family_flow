import 'package:flutter/material.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "The clan this week" leaderboard; the current member's row is
/// highlighted in their color.
class RecapLeaderboard extends StatelessWidget {
  const RecapLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ranking = context.watch<TribeService>().ranking;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  l10n.clanTitle,
                  style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
                ),
              ),
              Text(l10n.clanNote, style: AppTextStyles.meta),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final (index, member) in ranking.indexed)
          _LeaderboardRow(rank: index + 1, member: member),
      ],
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  const _LeaderboardRow({required this.rank, required this.member});

  final int rank;
  final Member member;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isYou = member.isCurrentUser;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isYou ? AppColors.soften(member.color, 0.2) : AppColors.surface,
        border: Border.all(
          color: isYou ? AppColors.soften(member.color, 0.35) : AppColors.line,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.cardPadding),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              '$rank',
              textAlign: TextAlign.center,
              style: AppTextStyles.points.copyWith(
                color: AppColors.inkTertiary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          MemberAvatar(member: member, filled: true),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: member.name,
                    style: AppTextStyles.taskName,
                    children: [
                      if (isYou)
                        TextSpan(
                          text: ' · ${l10n.youSuffix}',
                          style: AppTextStyles.meta,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  l10n.memberTasksDone(member.weeklyTasksDone),
                  style: AppTextStyles.meta,
                ),
              ],
            ),
          ),
          PointsBadge(
            text: '${member.weeklyPoints}',
            color: AppColors.deepen(member.color, 0.15),
            background: AppColors.soften(member.color, 0.2),
          ),
        ],
      ),
    );
  }
}
