# No dead code

The codebase contains **only what is used**. Anything not reached from the
running app (or its tests) is deleted, not left "just in case". Git is the
history — we don't keep dead code around as a backup.

## The rule

- **An unused file is deleted.** No file that nothing imports stays in the tree.
- **An unused class, widget, function or method is deleted.** If nothing
  references it, it goes.
- **Unused members go too:** dead fields, getters, constants, enum values, and
  unused parameters.
- **Unused imports** are removed (the linter flags these — see
  @.claude/rules/linting.md).
- **No commented-out code.** Delete it; git remembers it.
- **No leftovers after a move/rename.** When you move or rename a file, remove
  the old one in the **same change** — never leave a stale duplicate behind.

## When you touch something

- Removing the last usage of a symbol? Remove the symbol too, in the same
  change. A change that orphans code is not finished.
- Replacing an implementation? Delete the one you replaced.
- Deleting a file leaves an empty folder? Remove the folder.

## How to find it

- `flutter analyze` reports unused local variables, imports, private classes,
  fields and elements — a clean analyze (see @.claude/rules/linting.md) already
  catches most dead **private** code.
- Public symbols with no references won't be flagged by the analyzer. Before
  keeping any public API, confirm it's actually used (search for references);
  if it isn't, delete it.

## The only exception

Code that is genuinely used but *looks* unused — entry points, generated files
(`*.freezed.dart`, `*.g.dart`), and symbols consumed by reflection/DI wiring.
When something must stay despite looking unused, it is because it **is** used;
there is no "keep for later" exception.
