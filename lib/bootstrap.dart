import 'package:flutter/widgets.dart';

import 'app.dart';
import 'config/app_environment.dart';
import 'firebase/firebase_bootstrap.dart';

/// Séquence de démarrage commune aux deux environnements.
///
/// Appelée par `main_dev.dart` et `main_prod.dart`.
Future<void> bootstrap(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init(env);
  await initializeFirebase(env);
  runApp(const FamilyFlowApp());
}
