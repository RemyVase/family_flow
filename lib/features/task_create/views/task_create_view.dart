import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/task_create/controllers/task_create_controller.dart';
import 'package:our_tribe/features/task_create/views/widgets/task_create_moment_chips.dart';
import 'package:our_tribe/features/task_create/views/widgets/task_create_person_selector.dart';
import 'package:our_tribe/features/task_create/views/widgets/task_create_photos_row.dart';
import 'package:our_tribe/features/task_create/views/widgets/task_create_points_stepper.dart';
import 'package:our_tribe/features/task_create/views/widgets/task_create_recurrence_chips.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/app_text_field.dart';
import 'package:our_tribe/shared/widgets/primary_button.dart';
import 'package:our_tribe/shared/widgets/section_label.dart';
import 'package:our_tribe/shared/widgets/sticky_action_bar.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "New task" form.
class TaskCreateView extends StatelessWidget {
  const TaskCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskCreateController(),
      child: const _TaskCreateBody(),
    );
  }
}

class _TaskCreateBody extends StatelessWidget {
  const _TaskCreateBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<TaskCreateController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    const _TaskCreateTopBar(),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      label: l10n.taskNameLabel,
                      placeholder: l10n.taskNamePlaceholder,
                      autofocus: true,
                      onChanged: controller.setName,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      label: l10n.descriptionLabel,
                      placeholder: l10n.descriptionPlaceholder,
                      isOptional: true,
                      maxLines: 2,
                      onChanged: controller.setDescription,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.forWhoLabel),
                    const SizedBox(height: 9),
                    const TaskCreatePersonSelector(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.pointsSectionLabel),
                    const SizedBox(height: 9),
                    const TaskCreatePointsStepper(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.recurrenceLabel),
                    const SizedBox(height: 9),
                    const TaskCreateRecurrenceChips(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.whenLabel),
                    const SizedBox(height: 9),
                    const TaskCreateMomentChips(),
                    const SizedBox(height: AppSpacing.xl),
                    SectionLabel(l10n.photosLabel, suffix: l10n.optionalSuffix),
                    const SizedBox(height: 9),
                    const TaskCreatePhotosRow(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: StickyActionBar(
                child: PrimaryButton(
                  label: l10n.createTaskButton,
                  leadingIcon: AppIconData.plus,
                  // Creation will persist once the tasks backend exists;
                  // for now the flow simply closes.
                  onPressed: controller.canCreate ? () => context.pop() : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCreateTopBar extends StatelessWidget {
  const _TaskCreateTopBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        SizedBox(
          width: 56,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Text(
              l10n.cancelButton,
              style: AppTextStyles.action.copyWith(fontSize: 14.5),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              l10n.newTaskTitle,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 17),
            ),
          ),
        ),
        const SizedBox(width: 56),
      ],
    );
  }
}
