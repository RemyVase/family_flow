import 'package:flutter/material.dart';
import 'package:our_tribe/features/recap/views/recap/recap_controller.dart';
import 'package:our_tribe/features/recap/views/recap/widgets/family_task_list.dart';
import 'package:our_tribe/features/recap/views/recap/widgets/recap_bars_panel.dart';
import 'package:our_tribe/features/recap/views/recap/widgets/recap_header.dart';
import 'package:our_tribe/features/recap/views/recap/widgets/recap_leaderboard.dart';
import 'package:our_tribe/features/recap/views/recap/widgets/recap_reward_card.dart';
import 'package:our_tribe/features/recap/views/recap/widgets/recap_total_card.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/segmented_control.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Family tab: weekly recap (summary / task list).
class RecapView extends StatelessWidget {
  const RecapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecapController(
        context.read<TribeService>(),
        context.read<TaskService>(),
      ),
      child: const _RecapBody(),
    );
  }
}

class _RecapBody extends StatelessWidget {
  const _RecapBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = context.watch<RecapController>();

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
                const RecapHeader(),
                const SizedBox(height: 22),
                SegmentedControl(
                  options: [l10n.segmentSummary, l10n.segmentTasks],
                  selectedIndex: controller.segment.index,
                  onChanged: (index) =>
                      controller.selectSegment(RecapSegment.values[index]),
                ),
                const SizedBox(height: AppSpacing.xl),
                if (controller.segment == RecapSegment.tasks)
                  const FamilyTaskList()
                else ...const [
                  RecapTotalCard(),
                  SizedBox(height: AppSpacing.lg + 2),
                  RecapBarsPanel(),
                  SizedBox(height: AppSpacing.sectionGap),
                  RecapLeaderboard(),
                  SizedBox(height: AppSpacing.lg),
                  RecapRewardCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
