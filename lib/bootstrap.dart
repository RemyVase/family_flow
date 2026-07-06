import 'package:flutter/widgets.dart';
import 'package:our_tribe/app.dart';
import 'package:our_tribe/config/app_environment.dart';
import 'package:our_tribe/firebase/firebase_bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Startup sequence shared by both environments.
///
/// Called by `main_dev.dart` and `main_prod.dart`. Sentry wraps the app so
/// every uncaught error (framework + zone) is reported automatically; an
/// empty DSN simply disables the SDK.
Future<void> bootstrap(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init(env);
  await initializeFirebase(env);
  await SentryFlutter.init((options) {
    options.dsn = AppConfig.instance.sentryDsn;
    options.environment = env.name;
    options.attachStacktrace = true;
    options.tracesSampleRate = AppConfig.instance.isDev ? 1.0 : 0.2;
  }, appRunner: () => runApp(const OurTribeApp()));
}
