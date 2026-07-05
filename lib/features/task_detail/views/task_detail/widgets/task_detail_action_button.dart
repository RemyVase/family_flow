import 'package:flutter/material.dart';
import 'package:our_tribe/features/task_detail/views/task_detail/task_detail_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Sticky action of the detail screen: "mark as done" in the member color,
/// or the surface "done! undo" variant once completed (`.dt-btn`).
class TaskDetailActionButton extends StatelessWidget {
  const TaskDetailActionButton({super.key, required this.memberColor});

  final Color memberColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskDetailController>();

    if (!controller.task.isDone) {
      return PrimaryButton(
        label: l10n.markDoneButton,
        color: memberColor,
        leadingIcon: AppIconData.check,
        onPressed: controller.toggleDone,
      );
    }

    return GestureDetector(
      onTap: controller.toggleDone,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(AppRadii.button),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon(AppIconData.check),
            const SizedBox(width: AppSpacing.sm),
            Text(
              l10n.undoDoneButton,
              style: AppTextStyles.button.copyWith(
                color: AppColors.inkSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
