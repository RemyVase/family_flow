import 'package:flutter/material.dart';
import 'package:our_tribe/features/tasks/models/task.dart';
import 'package:our_tribe/features/tribe/models/member.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/icons/app_icon.dart';
import 'package:our_tribe/shared/icons/app_icon_data.dart';
import 'package:our_tribe/shared/utils/recurrence_label.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_durations.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:our_tribe/theme/app_text_styles.dart';

/// Task card (`.tcard`): checkbox, name + meta, optional photo thumbnail
/// and points pill.
///
/// When [member] is provided (week / family lists), the card shows a
/// member-colored left border and a member dot + name instead of the time.
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.member,
    this.onToggle,
    this.onTap,
  });

  final Task task;
  final Member? member;
  final VoidCallback? onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final recurrence = task.recurrence.label(l10n);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: task.isDone ? AppColors.surfaceSecondary : AppColors.surface,
          border: Border.all(color: AppColors.line),
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        foregroundDecoration: member == null
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.card),
                border: Border(
                  left: BorderSide(color: member!.color, width: 4),
                ),
              ),
        child: Row(
          children: [
            _TaskTick(isDone: task.isDone, onToggle: onToggle),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: task.isDone
                        ? AppTextStyles.taskName.copyWith(
                            color: AppColors.inkTertiary,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: const Color(0xFFD7D0C2),
                          )
                        : AppTextStyles.taskName,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Row(
                    children: [
                      if (member != null) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: member!.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Text(
                          member!.name,
                          style: AppTextStyles.meta.copyWith(
                            color: AppColors.deepen(member!.color, 0.15),
                          ),
                        ),
                      ] else ...[
                        const AppIcon(
                          AppIconData.clock,
                          size: 12,
                          color: AppColors.inkTertiary,
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Text(task.time, style: AppTextStyles.meta),
                      ],
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
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            if (task.hasPhoto) ...[
              const _TaskPhotoPlaceholder(),
              const SizedBox(width: AppSpacing.sm),
            ],
            PointsBadge(
              text: '${task.points}',
              color: task.isDone ? AppColors.inkTertiary : AppColors.ochre,
              background: task.isDone
                  ? AppColors.lineLight
                  : AppColors.ochreSoft,
            ),
          ],
        ),
      ),
    );
  }
}

/// 24px square checkbox with the springy "pop" on completion (`.tick`).
class _TaskTick extends StatelessWidget {
  const _TaskTick({required this.isDone, this.onToggle});

  final bool isDone;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onToggle,
      child: AnimatedContainer(
        duration: AppDurations.pop,
        curve: AppDurations.spring,
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isDone ? AppColors.accent : Colors.transparent,
          border: Border.all(
            color: isDone ? AppColors.accent : AppColors.checkboxBorder,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedScale(
          duration: AppDurations.pop,
          curve: AppDurations.spring,
          scale: isDone ? 1 : 0.5,
          child: AnimatedOpacity(
            duration: AppDurations.pop,
            opacity: isDone ? 1 : 0,
            child: const AppIcon(
              AppIconData.check,
              size: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// 40px striped photo placeholder (`.tphoto`).
class _TaskPhotoPlaceholder extends StatelessWidget {
  const _TaskPhotoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppRadii.photo),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.photo),
        child: const CustomPaint(painter: StripedPlaceholderPainter()),
      ),
    );
  }
}

/// Diagonal-stripe placeholder used wherever the design shows a photo slot.
class StripedPlaceholderPainter extends CustomPainter {
  const StripedPlaceholderPainter({this.stripeWidth = 7});

  final double stripeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final light = Paint()..color = const Color(0xFFF8F4EC);
    final dark = Paint()..color = const Color(0xFFF1ECE2);
    canvas.drawRect(Offset.zero & size, light);
    final extent = size.width + size.height;
    for (double d = -size.height; d < extent; d += stripeWidth * 2) {
      final stripe = Path()
        ..moveTo(d, 0)
        ..lineTo(d + stripeWidth, 0)
        ..lineTo(d + stripeWidth + size.height, size.height)
        ..lineTo(d + size.height, size.height)
        ..close();
      canvas.drawPath(stripe, dark);
    }
  }

  @override
  bool shouldRepaint(covariant StripedPlaceholderPainter oldDelegate) =>
      oldDelegate.stripeWidth != stripeWidth;
}
