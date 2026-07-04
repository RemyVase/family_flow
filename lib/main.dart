// Point d'entrée par défaut.
//
// L'application possède deux points d'entrée dédiés :
//   - lib/main_dev.dart  (environnement dev, avec bandeau vert)
//   - lib/main_prod.dart (environnement prod)
//
// Par commodité, `flutter run` sans cible démarre en mode dev.
// Utilise les configurations du launch.json ("Family Flow dev" / "prod").
import 'main_dev.dart' as dev;

void main() => dev.main();
