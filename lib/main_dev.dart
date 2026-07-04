import 'package:flutter/material.dart';

import 'app.dart';
import 'config/app_environment.dart';

/// Point d'entrée pour l'environnement de développement.
void main() {
  AppConfig.init(Environment.dev);
  runApp(const FamilyFlowApp());
}
