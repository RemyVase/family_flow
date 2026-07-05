import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/shared/widgets/app_tab_bar.dart';

/// Scaffold hosting the four tab branches and the central "+" FAB.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
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
