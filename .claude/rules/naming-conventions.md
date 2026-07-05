# Naming & file conventions

Consistency makes the project readable at a glance. These are enforced.

## Files & folders

- File and folder names in **`snake_case`**: `user_repository.dart`,
  `home_view.dart`, `features/user_profile/`.
- **One public class per file.** The file name matches the class in snake_case
  (`HomeController` → `home_controller.dart`). Small private helper widgets may
  share a file only when tightly coupled, but prefer one file each.
- Place files in the layer folder that matches their role (see
  @.claude/rules/architecture.md).

## Type suffixes (mandatory)

The role of a class is visible in its name:

| Role        | Suffix        | Example              |
|-------------|---------------|----------------------|
| View        | `View`        | `HomeView`           |
| Controller  | `Controller`  | `HomeController`     |
| Service     | `Service`     | `ProfileService`     |
| Repository  | `Repository`  | `UserRepository`     |
| Model       | (none)        | `User`, `Message`    |

Concrete repository implementations are prefixed by their backend:
`FirestoreUserRepository` (see @.claude/rules/dependency-injection.md).

## Imports

- Use **`package:` imports** (`package:our_tribe/...`), not relative imports
  (`../../`). This keeps imports stable when files move.
- Order: Dart SDK, then Flutter, then third-party packages, then project
  imports. Let the formatter/linter enforce grouping.

## Identifiers

- Classes/enums/typedefs: `UpperCamelCase`. Members/variables: `lowerCamelCase`.
- Constants: `lowerCamelCase` (Dart convention), not `SCREAMING_CAPS`.
- Booleans read as questions: `isLoading`, `hasError`, `canSubmit`.
- No abbreviations that aren't obvious; names are in English
  (see @.claude/rules/language.md).
