import 'package:flutter/material.dart';

import 'app.dart';
import 'config/app_environment.dart';

/// Point d'entrée pour l'environnement de production.
void main() {
  AppConfig.init(Environment.prod);
  runApp(const FamilyFlowApp());
}
