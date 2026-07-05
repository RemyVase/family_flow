import 'package:flutter/material.dart';
import 'package:our_tribe/features/tasks/views/unassigned/unassigned_controller.dart';
import 'package:our_tribe/features/tasks/views/unassigned/widgets/unassigned_empty_state.dart';
import 'package:our_tribe/features/tasks/views/unassigned/widgets/unassigned_task_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/shared/widgets/screen_header.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// "À répartir" screen: tasks without an owner, assignable in one tap.
class UnassignedView extends StatelessWidget {
  const UnassignedView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UnassignedController(context.read<TaskService>()),
      child: const _UnassignedBody(),
    );
  }
}

class _UnassignedBody extends StatelessWidget {
  const _UnassignedBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<UnassignedController>();

    return Scaffold(
      body: TribeBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.lg,
              AppSpacing.screenHorizontal,
              AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenHeader(
                  title: l10n.unassignedTitle,
                  subtitle: l10n.unassignedSubtitle,
                ),
                if (controller.isEmpty)
                  const UnassignedEmptyState()
                else
                  for (final task in controller.tasks)
                    UnassignedTaskCard(task: task),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
