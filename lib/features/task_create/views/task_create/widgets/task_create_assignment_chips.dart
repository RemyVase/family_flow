import 'package:flutter/material.dart';
import 'package:our_tribe/features/task_create/views/task_create/task_create_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/form_chip.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Assignment choices of the create form: one person / taking turns
/// (recurring tasks only) / up for grabs — with the contextual hint.
class TaskCreateAssignmentChips extends StatelessWidget {
  const TaskCreateAssignmentChips({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskCreateController>();
    final assignment = controller.assignment;

    final hint = switch (assignment) {
      TaskAssignment.person => null,
      TaskAssignment.rotate => l10n.assignRotateHint,
      TaskAssignment.unassigned => l10n.assignUnassignedHint,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            FormChip(
              label: l10n.assignPersonChip,
              icon: AppIconData.user,
              isSelected: assignment == TaskAssignment.person,
              onTap: () => controller.selectAssignment(TaskAssignment.person),
            ),
            if (controller.isRecurring)
              FormChip(
                label: l10n.assignRotateChip,
                icon: AppIconData.repeat,
                isSelected: assignment == TaskAssignment.rotate,
                onTap: () => controller.selectAssignment(TaskAssignment.rotate),
              ),
            FormChip(
              label: l10n.assignUnassignedChip,
              icon: AppIconData.users,
              isSelected: assignment == TaskAssignment.unassigned,
              onTap: () =>
                  controller.selectAssignment(TaskAssignment.unassigned),
            ),
          ],
        ),
        if (hint != null) ...[
          const SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(hint, style: AppTextStyles.meta.copyWith(height: 1.45)),
          ),
        ],
      ],
    );
  }
}
