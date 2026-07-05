import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tasks/views/unassigned/unassigned_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/utils/recurrence_label.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/shared/widgets/rotate_badge.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Ochre card of an unassigned task (`.ua-card`): task info on top,
/// member avatar row to assign it below.
class UnassignedTaskCard extends StatelessWidget {
  const UnassignedTaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.read<UnassignedController>();
    final members = context.watch<TribeService>().members;
    final recurrence = task.recurrence.label(l10n);

    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.ochreSoft,
        border: Border.all(color: AppColors.soften(AppColors.ochre, 0.24)),
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => context.push(AppRoute.taskDetail.path, extra: task),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.name, style: AppTextStyles.taskName),
                      const SizedBox(height: AppSpacing.xxs),
                      Row(
                        children: [
                          const AppIcon(
                            AppIconData.clock,
                            size: 12,
                            color: AppColors.inkTertiary,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Text(task.time, style: AppTextStyles.meta),
                          if (recurrence != null) ...[
                            const SizedBox(width: 11),
                            const AppIcon(
                              AppIconData.repeat,
                              size: 12,
                              color: AppColors.inkTertiary,
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Text(recurrence, style: AppTextStyles.meta),
                          ],
                          if (task.isRotating) ...[
                            const SizedBox(width: 11),
                            const RotateBadge(),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                PointsBadge(text: '${task.points}'),
              ],
            ),
          ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.only(top: 11),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.soften(AppColors.ochre, 0.2)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    task.isRotating ? l10n.rotateWhoLabel : l10n.assignToLabel,
                    style: AppTextStyles.action.copyWith(fontSize: 12.5),
                  ),
                ),
                for (final member in members) ...[
                  const SizedBox(width: 7),
                  GestureDetector(
                    onTap: () => controller.assignTask(task.id, member.id),
                    child: Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: member.color,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        member.initial,
                        style: GoogleFonts.figtree(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
