import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/week/controllers/week_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/task_card.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Vertical timeline (`.tl`): time gutter, rail with member-colored dots,
/// task cards and the accent "now" line.
class WeekTimeline extends StatelessWidget {
  const WeekTimeline({super.key});

  /// Demo "now" time shown on the marker row.
  static const String _nowTime = '14:02';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeekController>();

    return Column(
      children: [
        for (final task in controller.tasks) ...[
          _TimelineRow(task: task),
          if (task.id == WeekController.nowAfterTaskId)
            const _NowRow(time: _nowTime),
        ],
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<WeekController>();
    final member = context.watch<TribeService>().memberById(task.memberId);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                task.time,
                textAlign: TextAlign.right,
                style: AppTextStyles.meta,
              ),
            ),
          ),
          _TimelineRail(dotColor: member.color),
          Expanded(
            child: TaskCard(
              task: task,
              member: member,
              onToggle: () => controller.toggleTask(task.id),
              onTap: () => context.push(AppRoute.taskDetail.path, extra: task),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({required this.dotColor});

  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: Center(child: Container(width: 1.5, color: AppColors.line)),
          ),
          Positioned(
            top: 16,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: dotColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NowRow extends StatelessWidget {
  const _NowRow({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 24,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              time,
              textAlign: TextAlign.right,
              style: AppTextStyles.meta.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Center(
                    child: Container(width: 1.5, color: AppColors.line),
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.16),
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container(height: 1.5, color: AppColors.accent)),
          const SizedBox(width: 8),
          Text(
            l10n.nowLabel.toUpperCase(),
            style: AppTextStyles.meta.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
