import 'package:flutter/widgets.dart';
import 'package:our_tribe/app.dart';
import 'package:our_tribe/config/app_environment.dart';
import 'package:our_tribe/firebase/firebase_bootstrap.dart';

/// Startup sequence shared by both environments.
///
/// Called by `main_dev.dart` and `main_prod.dart`.
Future<void> bootstrap(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init(env);
  await initializeFirebase(env);
  runApp(const OurTribeApp());
}
