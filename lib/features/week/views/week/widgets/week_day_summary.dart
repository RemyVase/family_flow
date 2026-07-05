import 'package:flutter/material.dart';
import 'package:our_tribe/features/week/views/week/week_controller.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/shared/widgets/points_badge.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Line above the timeline: "N tâches · X faites" + day points pill.
class WeekDaySummary extends StatelessWidget {
  const WeekDaySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<WeekController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.daySummary(controller.tasks.length, controller.doneCount),
              style: AppTextStyles.action.copyWith(fontSize: 13),
            ),
          ),
          PointsBadge(text: l10n.pointsSuffix(controller.dayPoints)),
        ],
      ),
    );
  }
}
