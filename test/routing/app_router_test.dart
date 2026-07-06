import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/routing/app_router.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/app_tab_bar.dart';
import 'package:provider/provider.dart';

import '../helpers/test_stack.dart';

Widget buildTestApp(TestStack stack, GoRouter router) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthService>.value(value: stack.authService),
      ChangeNotifierProvider<TribeService>.value(value: stack.tribeService),
      ChangeNotifierProvider<TaskService>.value(value: stack.taskService),
    ],
    child: MaterialApp.router(
      routerConfig: router,
      locale: const Locale('fr'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}

void main() {
  testWidgets('should render every tab without exceptions', (tester) async {
    final stack = (await tester.runAsync(TestStack.signedInWithTribe))!;
    final router = createAppRouter(stack.authService);
    await tester.pumpWidget(buildTestApp(stack, router));

    for (final route in [
      AppRoute.home,
      AppRoute.week,
      AppRoute.family,
      AppRoute.profile,
    ]) {
      router.go(route.path);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'route ${route.path}');
    }
  });

  testWidgets('should show the home content above a bottom-anchored tab bar', (
    tester,
  ) async {
    final stack = (await tester.runAsync(TestStack.signedInWithTribe))!;
    final router = createAppRouter(stack.authService);
    await tester.pumpWidget(buildTestApp(stack, router));
    router.go(AppRoute.home.path);
    await tester.pumpAndSettle();

    expect(find.text('Salut la tribu'), findsOneWidget);

    final screenHeight =
        tester.view.physicalSize.height / tester.view.devicePixelRatio;
    final tabBarBottom = tester.getBottomLeft(find.byType(AppTabBar)).dy;
    expect(tabBarBottom, screenHeight);

    // The bar must hug its content, not inflate to fill the screen.
    final tabBarHeight = tester.getSize(find.byType(AppTabBar)).height;
    expect(tabBarHeight, lessThan(120));
  });

  testWidgets('should keep a signed-out user on the onboarding flow', (
    tester,
  ) async {
    final stack = TestStack();
    final router = createAppRouter(stack.authService);
    await tester.pumpWidget(buildTestApp(stack, router));
    await tester.pumpAndSettle();

    router.go(AppRoute.home.path);
    await tester.pumpAndSettle();

    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      AppRoute.onboardingWelcome.path,
    );
  });

  testWidgets('should send a signed-in user with a tribe into the app', (
    tester,
  ) async {
    final stack = (await tester.runAsync(TestStack.signedInWithTribe))!;
    final router = createAppRouter(stack.authService);
    await tester.pumpWidget(buildTestApp(stack, router));
    await tester.pumpAndSettle();

    // The initial onboarding location redirects straight to home.
    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      AppRoute.home.path,
    );
  });

  testWidgets('should park a signed-in user without a tribe on choose', (
    tester,
  ) async {
    final stack = TestStack();
    final router = createAppRouter(stack.authService);
    await tester.pumpWidget(buildTestApp(stack, router));
    await tester.pumpAndSettle();

    await tester.runAsync(
      () => stack.authService.signUp(
        firstName: 'Zoé',
        email: 'z@t.be',
        password: 'secret6',
      ),
    );
    await tester.pumpAndSettle();

    expect(
      router.routerDelegate.currentConfiguration.uri.path,
      AppRoute.onboardingChoose.path,
    );
  });
}
