import 'package:flutter/foundation.dart';

/// The environments supported by the application.
enum Environment { dev, prod }

/// Global application configuration, depending on the environment.
///
/// Initialized once at startup via [AppConfig.init] (called by the
/// `main_dev.dart` / `main_prod.dart` entry points).
class AppConfig {
  AppConfig._({
    required this.environment,
    required this.appName,
  });

  final Environment environment;
  final String appName;

  static AppConfig? _instance;

  /// The current instance. Must be initialized before use.
  static AppConfig get instance {
    assert(_instance != null, 'AppConfig.init() must be called at startup.');
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
      debugPrint('AppConfig initialized for: ${environment.name}');
    }
  }

  bool get isDev => environment == Environment.dev;
  bool get isProd => environment == Environment.prod;
}
