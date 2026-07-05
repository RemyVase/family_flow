import 'package:flutter/material.dart';
import 'package:our_tribe/features/home/views/home/home_controller.dart';
import 'package:our_tribe/features/home/views/home/widgets/home_header.dart';
import 'package:our_tribe/features/home/views/home/widgets/home_progress_card.dart';
import 'package:our_tribe/features/home/views/home/widgets/home_task_section.dart';
import 'package:our_tribe/features/home/views/home/widgets/unassigned_banner.dart';
import 'package:our_tribe/features/tasks/models/task_moment.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/shared/widgets/tribe_background.dart';
import 'package:our_tribe/theme/app_spacing.dart';
import 'package:provider/provider.dart';

/// Home tab: today's tasks grouped by moment of the day.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(context.read<TaskService>()),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

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
                HomeHeader(),
                SizedBox(height: 22),
                HomeProgressCard(),
                UnassignedBanner(),
                HomeTaskSection(moment: TaskMoment.morning),
                HomeTaskSection(moment: TaskMoment.afternoon),
                HomeTaskSection(moment: TaskMoment.evening),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
