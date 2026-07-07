import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_tribe/config/app_environment.dart';
import 'package:our_tribe/features/analytics/repositories/analytics_repository.dart';
import 'package:our_tribe/features/analytics/repositories/firebase_analytics_repository.dart';
import 'package:our_tribe/features/auth/repositories/auth_repository.dart';
import 'package:our_tribe/features/auth/repositories/firebase_auth_repository.dart';
import 'package:our_tribe/features/auth/repositories/firestore_user_repository.dart';
import 'package:our_tribe/features/auth/repositories/user_repository.dart';
import 'package:our_tribe/features/notifications/repositories/firebase_push_messaging_repository.dart';
import 'package:our_tribe/features/notifications/repositories/firestore_notification_prefs_repository.dart';
import 'package:our_tribe/features/notifications/repositories/notification_prefs_repository.dart';
import 'package:our_tribe/features/notifications/repositories/push_messaging_repository.dart';
import 'package:our_tribe/features/tasks/repositories/firestore_task_repository.dart';
import 'package:our_tribe/features/tasks/repositories/task_repository.dart';
import 'package:our_tribe/features/tribe/repositories/firestore_tribe_repository.dart';
import 'package:our_tribe/features/tribe/repositories/tribe_repository.dart';
import 'package:our_tribe/firebase/firebase_services.dart';
import 'package:our_tribe/l10n/app_localizations.dart';
import 'package:our_tribe/routing/analytics_screen_tracker.dart';
import 'package:our_tribe/routing/app_router.dart';
import 'package:our_tribe/services/analytics_service.dart';
import 'package:our_tribe/services/auth_service.dart';
import 'package:our_tribe/services/notification_service.dart';
import 'package:our_tribe/services/task_service.dart';
import 'package:our_tribe/services/tribe_service.dart';
import 'package:our_tribe/shared/widgets/dev_banner.dart';
import 'package:our_tribe/theme/app_theme.dart';
import 'package:provider/provider.dart';

class OurTribeApp extends StatelessWidget {
  const OurTribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // The single place where concrete backends are named — everything
      // else depends on the interfaces (dependency-injection rule).
      providers: [
        Provider<AuthRepository>(
          create: (_) => FirebaseAuthRepository(FirebaseServices.auth),
        ),
        Provider<UserRepository>(
          create: (_) => FirestoreUserRepository(FirebaseServices.firestore),
        ),
        Provider<TribeRepository>(
          create: (_) => FirestoreTribeRepository(FirebaseServices.firestore),
        ),
        Provider<TaskRepository>(
          create: (_) => FirestoreTaskRepository(FirebaseServices.firestore),
        ),
        Provider<PushMessagingRepository>(
          create: (_) =>
              FirebasePushMessagingRepository(FirebaseServices.messaging),
        ),
        Provider<NotificationPrefsRepository>(
          create: (_) =>
              FirestoreNotificationPrefsRepository(FirebaseServices.firestore),
        ),
        Provider<AnalyticsRepository>(
          create: (_) =>
              FirebaseAnalyticsRepository(FirebaseServices.analytics),
        ),
        Provider<AnalyticsService>(
          create: (c) => AnalyticsService(c.read<AnalyticsRepository>()),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (c) => AuthService(
            c.read<AuthRepository>(),
            c.read<UserRepository>(),
            c.read<AnalyticsService>(),
          ),
        ),
        ChangeNotifierProvider<TribeService>(
          create: (c) => TribeService(
            c.read<TribeRepository>(),
            c.read<AuthService>(),
            c.read<AnalyticsService>(),
          ),
        ),
        ChangeNotifierProvider<TaskService>(
          create: (c) => TaskService(
            c.read<TaskRepository>(),
            c.read<TribeService>(),
            c.read<AuthService>(),
            c.read<AnalyticsService>(),
          ),
        ),
        // Not lazy: the device token must be registered as soon as a
        // signed-in user opens the app, not when a screen first reads it.
        ChangeNotifierProvider<NotificationService>(
          lazy: false,
          create: (c) => NotificationService(
            c.read<PushMessagingRepository>(),
            c.read<NotificationPrefsRepository>(),
            c.read<UserRepository>(),
            c.read<AuthService>(),
            c.read<AnalyticsService>(),
          ),
        ),
      ],
      child: const _OurTribeMaterialApp(),
    );
  }
}

/// Owns the router, which is created once with the [AuthService] so the
/// auth guard can listen to it.
class _OurTribeMaterialApp extends StatefulWidget {
  const _OurTribeMaterialApp();

  @override
  State<_OurTribeMaterialApp> createState() => _OurTribeMaterialAppState();
}

class _OurTribeMaterialAppState extends State<_OurTribeMaterialApp> {
  late final GoRouter _router = createAppRouter(context.read<AuthService>());
  late final AnalyticsScreenTracker _screenTracker = AnalyticsScreenTracker(
    _router,
    context.read<AnalyticsService>(),
  );

  @override
  void initState() {
    super.initState();
    // Touch the tracker so screen views are logged from the first frame.
    _screenTracker;
  }

  @override
  void dispose() {
    _screenTracker.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return MaterialApp.router(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // The dev strip is added here so it stays visible on every screen.
      builder: (context, child) {
        return DevBanner(
          enabled: config.isDev,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
