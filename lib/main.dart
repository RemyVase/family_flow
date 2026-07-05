// Default entry point.
//
// The application has two dedicated entry points:
//   - lib/main_dev.dart  (dev environment, with the green strip)
//   - lib/main_prod.dart (prod environment)
//
// For convenience, `flutter run` without a target starts in dev mode.
// Use the launch.json configurations ("Our Tribe (dev)" / "(prod)").
import 'package:our_tribe/main_dev.dart' as dev;

void main() => dev.main();
