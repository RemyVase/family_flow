# Localization — user-facing strings

Code is English-only (see @.claude/rules/language.md), but strings shown to the
user go through a **localization layer** — they are **never hardcoded inline**
in widgets.

## Setup

- Use `flutter_localizations` + `intl` with ARB files and Flutter's built-in
  `gen-l10n` code generation.
- ARB files live in `lib/l10n/` (`app_en.arb`, `app_fr.arb`, …).
- Generated `AppLocalizations` is accessed in widgets via
  `AppLocalizations.of(context)`.

```dart
// ❌ never
Text('Bienvenue dans la tribu')

// ✅ always
Text(AppLocalizations.of(context)!.welcomeTitle)
```

## Rules

- Every user-visible string has a key in the ARB files; add the key in **all**
  locales when you introduce it.
- Keys are descriptive and in English (`welcomeTitle`, `errorNetworkGeneric`),
  grouped by feature where helpful.
- Use ARB placeholders/plurals for dynamic values — no string concatenation to
  build sentences.
- No French (or any language) string literals scattered in widgets — the linter
  and reviews should flag them.

> Prerequisites: add `flutter_localizations` (SDK) and `intl` to dependencies,
> enable `generate: true` under `flutter:` in `pubspec.yaml`, and add an
> `l10n.yaml`.
