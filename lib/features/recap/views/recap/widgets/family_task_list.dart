import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/widgets/task_card.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// "Tasks" sub-tab of the family recap: filter chips + grouped task list.
class FamilyTaskList extends StatelessWidget {
  const FamilyTaskList({super.key});

  String _filterLabel(AppLocalizations l10n, TaskFilter filter) =>
      switch (filter) {
        TaskFilter.all => l10n.filterAll,
        TaskFilter.todo => l10n.filterTodo,
        TaskFilter.done => l10n.filterDone,
        TaskFilter.recurring => l10n.filterRecurring,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RecapController>();
    final filtered = controller.filteredTasks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final filter in TaskFilter.values) ...[
                if (filter != TaskFilter.values.first)
                  const SizedBox(width: AppSpacing.sm),
                _FilterChip(
                  label: _filterLabel(l10n, filter),
                  count: controller.countFor(filter),
                  isSelected: controller.filter == filter,
                  onTap: () => controller.selectFilter(filter),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        if (controller.filter == TaskFilter.all) ...[
          _TaskGroup(
            title: l10n.groupTodo,
            tasks: filtered.where((t) => !t.isDone).toList(),
          ),
          _TaskGroup(
            title: l10n.groupDone,
            tasks: filtered.where((t) => t.isDone).toList(),
          ),
        ] else if (filtered.isEmpty)
          const _EmptyState()
        else
          for (final task in filtered) _FamilyTaskCard(task: task),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.line,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: AppTextStyles.action.copyWith(
                color: isSelected ? Colors.white : AppColors.inkSecondary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.28)
                    : AppColors.lineLight,
                borderRadius: BorderRadius.circular(AppSpacing.xl),
              ),
              child: Text(
                '$count',
                style: AppTextStyles.meta.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.inkTertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskGroup extends StatelessWidget {
  const _TaskGroup({required this.title, required this.tasks});

  final String title;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                Expanded(child: Text(title, style: AppTextStyles.sectionTitle)),
                Text('${tasks.length}', style: AppTextStyles.meta),
              ],
            ),
          ),
          const SizedBox(height: 11),
          for (final task in tasks) _FamilyTaskCard(task: task),
        ],
      ),
    );
  }
}

class _FamilyTaskCard extends StatelessWidget {
  const _FamilyTaskCard({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RecapController>();
    final member = context.watch<TribeService>().memberById(task.memberId);

    return TaskCard(
      task: task,
      member: member,
      onToggle: () => controller.toggleTask(task.id),
      onTap: () => context.push(AppRoute.taskDetail.path, extra: task),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: Column(
          children: [
            const AppIcon(
              AppIconData.sparkle,
              size: 30,
              color: AppColors.inkTertiary,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.emptyListMessage,
              style: AppTextStyles.action.copyWith(
                fontSize: 14,
                color: AppColors.inkTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
