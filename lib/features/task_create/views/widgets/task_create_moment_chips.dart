import 'package:flutter/material.dart';
import 'package:our_tribe/features/task_create/controllers/task_create_controller.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/utils/task_moment_style.dart';
import 'package:our_tribe/shared/widgets/form_chip.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Moment-of-day choices of the create form (`.cf-chips`).
class TaskCreateMomentChips extends StatelessWidget {
  const TaskCreateMomentChips({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskCreateController>();

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final moment in TaskMoment.values)
          FormChip(
            label: l10n.momentChip(moment.shortLabel(l10n), moment.defaultTime),
            isSelected: controller.moment == moment,
            onTap: () => controller.selectMoment(moment),
          ),
      ],
    );
  }
}
