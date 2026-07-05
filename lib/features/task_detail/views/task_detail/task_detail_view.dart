import 'package:flutter/material.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/task_detail_controller.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/widgets/task_detail_action_button.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/widgets/task_detail_assignee_card.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/widgets/task_detail_banner.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/widgets/task_detail_header.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/utils/recurrence_label.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Task detail: banner, title, chips, description, assignee, activity
/// and the sticky "mark as done" action.
class TaskDetailView extends StatelessWidget {
  const TaskDetailView({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskDetailController(task),
      child: const _TaskDetailBody(),
    );
  }
}

class _TaskDetailBody extends StatelessWidget {
  const _TaskDetailBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskDetailController>();
    final task = controller.task;
    final member = context.watch<TribeService>().memberById(task.memberId);
    final recurrence = task.recurrence.label(l10n);

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
                    const TaskDetailHeader(),
                    const SizedBox(height: AppSpacing.lg),
                    TaskDetailBanner(task: task, member: member),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            task.name,
                            style: AppTextStyles.screenTitle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        PointsBadge(text: '${task.points}'),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        _DetailChip(
                          icon: AppIconData.clock,
                          label: l10n.todayAt(task.time),
                        ),
                        if (recurrence != null)
                          _DetailChip(
                            icon: AppIconData.repeat,
                            label: recurrence,
                          ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SectionLabel(l10n.descriptionLabel),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      task.description ?? l10n.defaultTaskDescription,
                      style: AppTextStyles.body.copyWith(height: 1.55),
                    ),
                    const SizedBox(height: AppSpacing.lg + 2),
                    TaskDetailAssigneeCard(member: member),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.activityLabel),
                    const SizedBox(height: AppSpacing.sm),
                    _ActivityRow(
                      memberColor: member.color,
                      text: l10n.activityLastWeek(member.name, task.points),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: StickyActionBar(
                child: TaskDetailActionButton(memberColor: member.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  const _DetailChip({required this.icon, required this.label});

  final AppIconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon, size: 14),
          const SizedBox(width: 5),
          Text(label, style: AppTextStyles.action.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.memberColor, required this.text});

  final Color memberColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: memberColor,
              shape: BoxShape.circle,
            ),
            child: const AppIcon(
              AppIconData.check,
              size: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.action.copyWith(fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}
