# Language — English only

The codebase is versioned and shared. **Everything in code files must be in
English.** No French anywhere.

This applies to:

- Identifiers: class, method, variable, field, parameter, enum and constant
  names.
- Comments and documentation comments (`///`).
- Log messages, error messages and exceptions.
- File and folder names.
- Commit messages and code review comments.
- Route names and internal keys.

Exception: **user-facing strings** shown in the UI may be in the app's display
language, but they must go through the localization layer, never hardcoded
inline. Do not scatter French string literals across widgets.

If you find French in existing code, translate it as part of your change.
