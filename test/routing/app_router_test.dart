import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_route.dart';
import 'package:our_tribe/routing/app_router.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/app_tab_bar.dart';
import 'package:provider/provider.dart';

Widget buildTestApp() {
  return ChangeNotifierProvider<TribeService>(
    create: (_) => TribeService(),
    child: MaterialApp.router(
      routerConfig: appRouter,
      locale: const Locale('fr'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ),
  );
}

void main() {
  testWidgets('should render every tab without exceptions', (tester) async {
    await tester.pumpWidget(buildTestApp());

    for (final route in [
      AppRoute.home,
      AppRoute.week,
      AppRoute.family,
      AppRoute.profile,
    ]) {
      appRouter.go(route.path);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'route ${route.path}');
    }
  });

  testWidgets('should show the home content above a bottom-anchored tab bar', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestApp());
    appRouter.go(AppRoute.home.path);
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
}
