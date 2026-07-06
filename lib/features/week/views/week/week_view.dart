import 'package:flutter/material.dart';
import 'package:our_tribe/features/week/views/week/week_controller.dart';
import 'package:our_tribe/features/week/views/week/widgets/week_day_strip.dart';
import 'package:our_tribe/features/week/views/week/widgets/week_day_summary.dart';
import 'package:our_tribe/features/week/views/week/widgets/week_header.dart';
import 'package:our_tribe/features/week/views/week/widgets/week_timeline.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Week tab: day strip + timeline of the family's tasks.
class WeekView extends StatelessWidget {
  const WeekView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeekController(context.read<TaskService>()),
      child: const _WeekBody(),
    );
  }
}

class _WeekBody extends StatelessWidget {
  const _WeekBody();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TribeBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.lg,
              AppSpacing.screenHorizontal,
              AppSpacing.xxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeekHeader(),
                SizedBox(height: 22),
                WeekDayStrip(),
                SizedBox(height: AppSpacing.lg),
                WeekDaySummary(),
                SizedBox(height: AppSpacing.lg),
                WeekTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
