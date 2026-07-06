import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/app_tab_bar.dart';
import 'package:our_tribe/theme/app_colors.dart';
import 'package:provider/provider.dart';

/// Scaffold hosting the four tab branches and the central "+" FAB.
///
/// Tabs render only once the tribe data has arrived — screens inside the
/// shell all assume the members list is available.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final isReady = context.watch<TribeService>().isReady;

    if (!isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.accent)),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppTabBar(
        currentIndex: navigationShell.currentIndex,
        onTabSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        onCreatePressed: () => context.push(AppRoute.taskCreate.path),
      ),
    );
  }
}
