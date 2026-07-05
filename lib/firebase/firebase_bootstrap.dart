import 'package:firebase_core/firebase_core.dart';

import '../config/app_environment.dart';
import '../firebase_options_dev.dart' as dev;
import '../firebase_options_prod.dart' as prod;

/// Initialise Firebase avec les options correspondant à [env].
///
/// Les fichiers `firebase_options_dev.dart` / `firebase_options_prod.dart`
/// sont générés par `flutterfire configure` (un par projet Firebase).
Future<FirebaseApp> initializeFirebase(Environment env) {
  final options = switch (env) {
    Environment.dev => dev.DefaultFirebaseOptions.currentPlatform,
    Environment.prod => prod.DefaultFirebaseOptions.currentPlatform,
  };
  return Firebase.initializeApp(options: options);
}
