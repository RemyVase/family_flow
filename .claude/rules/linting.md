# Linting — zero warnings

The project must stay at **zero analyzer warnings**. `flutter analyze` is clean
before every commit — no exceptions, no "we'll fix it later".

## Rules

- **`flutter analyze` must report no issues** (errors, warnings, or infos)
  before committing.
- Strict lint set on top of `flutter_lints` in `analysis_options.yaml`. At
  minimum:
  - `prefer_const_constructors`, `prefer_const_declarations`
  - `avoid_print` (use the logging / Sentry path, see
    @.claude/rules/error-handling.md)
  - `always_declare_return_types`
  - `require_trailing_commas` (keeps formatting stable and diffs small)
  - `prefer_final_locals`
- Treat warnings as errors in CI so nothing regresses.
- **Don't suppress lints to silence them.** An `// ignore:` is allowed only with
  a short justification comment and only when the rule is genuinely wrong for
  that line.
- Run `dart format .` — formatting is not a matter of taste, the formatter
  decides.

## Before committing

```bash
dart format .
flutter analyze   # must be clean
flutter test
```
