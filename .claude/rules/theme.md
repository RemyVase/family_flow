# Theme & constants

No magic values in widgets. Colors, spacing, radii, text styles and other design
tokens are centralized and referenced by name.

## Where

- Design tokens and the app `ThemeData` live in `lib/theme/`:
  - `app_colors.dart` — the color palette
  - `app_spacing.dart` — spacing / sizing scale (e.g. `xs`, `sm`, `md`, …)
  - `app_text_styles.dart` — text styles
  - `app_theme.dart` — assembles `ThemeData` from the tokens
- Cross-cutting non-design constants live in `lib/shared/` (or a feature's own
  folder when scoped to it).

## Rules

- **No magic numbers or raw colors in widgets.** Not `Color(0xFF...)`, not
  `EdgeInsets.all(16)` — use `AppColors.primary`, `AppSpacing.md`, etc.
- Read styling from the theme via `Theme.of(context)` where Flutter provides it
  (text styles, color scheme) rather than re-declaring values.
- Tokens are defined once; if a value is used in two places, it must come from
  the same constant.
- Keep the palette and scale small and intentional — add a token deliberately,
  don't invent one-off values per screen.

```dart
// ❌ never
Padding(padding: const EdgeInsets.all(16), child: ...)

// ✅ always
Padding(padding: const EdgeInsets.all(AppSpacing.md), child: ...)
```
