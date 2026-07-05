# Our Tribe

Flutter application backed by Firebase (Auth, Cloud Firestore, Cloud Storage).

## Stack

- **Flutter** (Dart SDK `^3.9.2`)
- **Firebase**: `firebase_auth`, `cloud_firestore`, `firebase_storage`
- **Routing**: GoRouter
- **State management**: Provider (`ChangeNotifier` + `context.watch` / `context.read`)
- **Models**: Freezed (code generation — never written by hand)
- **Monitoring**: Sentry (global catcher, per-flavor DSN)
- **Localization**: `flutter_localizations` + `intl` (ARB / `gen-l10n`)

The app has two flavors: `dev` and `prod` (see `lib/main_dev.dart`,
`lib/main_prod.dart`, `lib/config/app_environment.dart`).

## Project rules

Architecture conventions are non-negotiable. Read them before writing code:

- @.claude/rules/language.md — English-only in all code files
- @.claude/rules/architecture.md — feature-first structure, folders, splitting
- @.claude/rules/naming-conventions.md — file/type naming, imports
- @.claude/rules/models-freezed.md — creating and generating Freezed models
- @.claude/rules/data-mapping.md — Firestore ↔ models via `withConverter`
- @.claude/rules/firestore-security.md — security rules per collection, versioned
- @.claude/rules/state-management.md — controllers, views, Provider
- @.claude/rules/dependency-injection.md — swappable backend via interfaces
- @.claude/rules/streams.md — Firestore streams & controller disposal
- @.claude/rules/routing.md — GoRouter
- @.claude/rules/error-handling.md — Sentry global catcher, breadcrumbs
- @.claude/rules/localization.md — user-facing strings via ARB
- @.claude/rules/theme.md — design tokens, no magic values
- @.claude/rules/testing.md — per-feature test suites
- @.claude/rules/linting.md — zero-warning policy
- @.claude/rules/no-dead-code.md — delete unused files, classes and code

## Useful commands

```bash
flutter pub get                                  # install dependencies
dart run build_runner build --delete-conflicting-outputs   # generate Freezed
dart run build_runner watch --delete-conflicting-outputs   # continuous generation
flutter run --flavor dev -t lib/main_dev.dart    # run in dev
flutter run --flavor prod -t lib/main_prod.dart  # run in prod
flutter analyze                                  # lint
flutter test                                     # tests
```
