import 'package:flutter/material.dart';
import 'package:our_tribe/features/task_create/controllers/task_create_controller.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/member_avatar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Row of member cards to pick the assignee (`.cf-people`).
class TaskCreatePersonSelector extends StatelessWidget {
  const TaskCreatePersonSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final members = context.watch<TribeService>().members;

    return Row(
      children: [
        for (final (index, member) in members.indexed) ...[
          if (index > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(child: _PersonCard(member: member)),
        ],
      ],
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.member});

  final Member member;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskCreateController>();
    final isSelected = controller.memberId == member.id;
    final label = member.isCurrentUser ? l10n.meLabel : member.name;

    return GestureDetector(
      onTap: () => controller.selectMember(member.id),
      child: Container(
        padding: const EdgeInsets.only(top: 11, bottom: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.soften(member.color, 0.2)
              : AppColors.surface,
          border: Border.all(color: isSelected ? member.color : AppColors.line),
          borderRadius: BorderRadius.circular(AppRadii.input),
        ),
        child: Column(
          children: [
            MemberAvatar(member: member, size: 32),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: AppTextStyles.action.copyWith(
                fontSize: 12.5,
                color: isSelected
                    ? AppColors.deepen(member.color, 0.15)
                    : AppColors.inkSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
