import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/week_switcher.dart';
import 'package:our_tribe/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

/// Recap header: date range + tribe name, week switcher on the right.
class RecapHeader extends StatelessWidget {
  const RecapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tribeService = context.watch<TribeService>();
    final locale = Localizations.localeOf(context).toString();

    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));
    final weekNumber =
        ((now.difference(DateTime(now.year)).inDays +
                    DateTime(now.year).weekday) /
                7)
            .ceil();
    final range =
        '${monday.day} – ${sunday.day} ${DateFormat.MMMM(locale).format(sunday)}';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(range, style: AppTextStyles.headerKicker),
              const SizedBox(height: 3),
              Text(tribeService.tribeName, style: AppTextStyles.greeting),
            ],
          ),
        ),
        WeekSwitcher(weekNumber: weekNumber),
      ],
    );
  }
}
