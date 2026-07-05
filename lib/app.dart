import 'package:flutter/material.dart';
import 'package:our_tribe/config/app_environment.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/app_router.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/dev_banner.dart';
import 'package:our_tribe/theme/app_theme.dart';
import 'package:provider/provider.dart';

class OurTribeApp extends StatelessWidget {
  const OurTribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MultiProvider(
      providers: [
        // Cross-feature services. Repositories will be bound to their
        // interfaces here once the backend is wired.
        ChangeNotifierProvider<TribeService>(create: (_) => TribeService()),
      ],
      child: MaterialApp.router(
        title: config.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        routerConfig: appRouter,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        // The dev strip is added here so it stays visible on every screen.
        builder: (context, child) {
          return DevBanner(
            enabled: config.isDev,
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
