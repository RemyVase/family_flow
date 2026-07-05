import 'package:flutter/material.dart';
import 'package:our_tribe/features/task_create/views/task_create/task_create_controller.dart';
import 'package:our_tribe/features/tasks/models/task_recurrence.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/utils/recurrence_label.dart';
import 'package:our_tribe/shared/widgets/form_chip.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Recurrence choices of the create form (`.cf-chips`).
class TaskCreateRecurrenceChips extends StatelessWidget {
  const TaskCreateRecurrenceChips({super.key});

  /// Options offered by the form, in display order.
  static const List<TaskRecurrence> _options = [
    TaskRecurrence.once,
    TaskRecurrence.daily,
    TaskRecurrence.weekly,
    TaskRecurrence.thriceDaily,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskCreateController>();

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final option in _options)
          FormChip(
            label: option.label(l10n) ?? l10n.recurrenceOnce,
            icon: option == TaskRecurrence.once ? null : AppIconData.repeat,
            isSelected: controller.recurrence == option,
            onTap: () => controller.selectRecurrence(option),
          ),
      ],
    );
  }
}
