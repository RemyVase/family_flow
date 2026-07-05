import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_tribe/features/week/controllers/week_controller.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:our_tribe/theme/app_radii.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// 7-day strip (`.daystrip`), selected day highlighted in accent.
class WeekDayStrip extends StatelessWidget {
  const WeekDayStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeekController>();

    return Row(
      children: [
        for (final (index, day) in controller.days.indexed) ...[
          if (index > 0) const SizedBox(width: 6),
          Expanded(child: _DayCell(day: day)),
        ],
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.day});

  final WeekDay day;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeekController>();
    final locale = Localizations.localeOf(context).toString();
    final isSelected = day.date == controller.selectedDate;
    final color = isSelected ? AppColors.accent : null;

    return GestureDetector(
      onTap: () => controller.selectDay(day.date),
      child: Container(
        padding: const EdgeInsets.only(top: 9, bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.line : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(AppRadii.input),
        ),
        child: Column(
          children: [
            Text(
              DateFormat.E(locale).format(day.date)[0].toUpperCase(),
              style: AppTextStyles.meta.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color ?? AppColors.inkTertiary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${day.date.day}',
              style: AppTextStyles.sectionTitle.copyWith(
                fontSize: 16,
                height: 1,
                color: color ?? AppColors.ink,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < day.taskCount.clamp(0, 3); i++)
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: color ?? AppColors.inkTertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
