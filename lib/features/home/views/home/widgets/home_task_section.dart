import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/home/views/home/home_controller.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/utils/task_moment_style.dart';
import 'package:our_tribe/shared/widgets/task_card.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// One moment section of the home list: tinted icon pill, title,
/// done counter and the moment's task cards.
class HomeTaskSection extends StatelessWidget {
  const HomeTaskSection({super.key, required this.moment});

  final TaskMoment moment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<HomeController>();
    final tasks = controller.tasksFor(moment);
    if (tasks.isEmpty) return const SizedBox.shrink();

    final doneCount = tasks.where((t) => t.isDone).length;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: moment.softColor,
                    borderRadius: BorderRadius.circular(AppRadii.sectionIcon),
                  ),
                  child: AppIcon(moment.icon, size: 15, color: moment.color),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  moment.sectionTitle(l10n),
                  style: AppTextStyles.sectionTitle,
                ),
                const Spacer(),
                Text(
                  l10n.sectionCount(doneCount, tasks.length),
                  style: AppTextStyles.meta,
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          for (final task in tasks)
            TaskCard(
              task: task,
              onToggle: () => controller.toggleTask(task.id),
              onTap: () => context.push(AppRoute.taskDetail.path, extra: task),
            ),
        ],
      ),
    );
  }
}
