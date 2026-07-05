import 'package:flutter/material.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Assignee card of the detail screen (`.dt-assignee`).
class TaskDetailAssigneeCard extends StatelessWidget {
  const TaskDetailAssigneeCard({super.key, required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Row(
        children: [
          MemberAvatar(member: member, size: 44),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.assignedTo.toUpperCase(),
                  style: AppTextStyles.kicker.copyWith(
                    fontSize: 11,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 1),
                Text.rich(
                  TextSpan(
                    text: member.name,
                    style: AppTextStyles.sectionTitle.copyWith(fontSize: 16),
                    children: [
                      if (member.isCurrentUser)
                        TextSpan(
                          text: ' · ${l10n.youSuffix}',
                          style: AppTextStyles.meta,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            l10n.changeAction,
            style: AppTextStyles.action.copyWith(
              fontSize: 13,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
