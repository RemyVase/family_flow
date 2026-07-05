import 'package:flutter/foundation.dart';

/// Les environnements supportés par l'application.
enum Environment { dev, prod }

/// Configuration globale de l'application, dépendante de l'environnement.
///
/// Initialisée une seule fois au démarrage via [AppConfig.init] (appelé par
/// les points d'entrée `main_dev.dart` / `main_prod.dart`).
class AppConfig {
  AppConfig._({
    required this.environment,
    required this.appName,
  });

  final Environment environment;
  final String appName;

  static AppConfig? _instance;

  /// L'instance courante. Doit être initialisée avant utilisation.
  static AppConfig get instance {
    assert(_instance != null, 'AppConfig.init() doit être appelé au démarrage.');
    return _instance!;
  }

  static void init(Environment environment) {
    _instance = AppConfig._(
      environment: environment,
      appName: switch (environment) {
        Environment.dev => 'Our Tribe (DEV)',
        Environment.prod => 'Our Tribe',
      },
    );
    if (kDebugMode) {
      debugPrint('AppConfig initialisé pour: ${environment.name}');
    }
  }

  bool get isDev => environment == Environment.dev;
  bool get isProd => environment == Environment.prod;
}
